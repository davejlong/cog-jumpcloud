#!/usr/bin/env ruby
# frozen_string_literal: true

require 'cog/command'
require 'json'

require_relative 'helpers'

module CogCmd
  module JumpCloud
    ##
    ## Look up information about users
    ##
    class Systems < Cog::Command
      include Helpers

      PATH = "#{BASE_PATH}/systems"
      TEMPLATE = 'systems'

      def run_command
        resp = http_client.get(PATH, headers)
        if resp.code.to_i == 200
          response.content = parse_body(resp.body)
          response.template = TEMPLATE
        else
          response.content = "Failed to get users: \`#{resp.body}\`"
        end
        response
      end

      def parse_body(body)
        JSON.parse(body)['results'].map do |sys|
          sys['ipList'] = sys['networkInterfaces']
            .select { |iface| iface['family'] == 'IPv4' }
            .map { |iface| iface['address'] }
            .join(', ')
          sys
        end
      end
    end
  end
end
