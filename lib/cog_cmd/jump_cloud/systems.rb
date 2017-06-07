# frozen_string_literal: true

require 'cog/command'
require 'json'

require_relative 'helpers'

module CogCmd
  module JumpCloud
    ##
    ## Commands for working with systems
    ##
    class Systems < Cog::Command
      include Helpers

      PATH = "#{BASE_PATH}/systems"
      TEMPLATE = 'systems'

      def run_command
        case subcommand
        when 'list', nil
          list
        when 'get'
          get
        end
      end

      def list
        resp = http_client.get(PATH, headers)
        if resp.code.to_i == 200
          response.content = results(resp.body)
          response.template = TEMPLATE
        else
          response.content = "Failed to get systems: \`#{resp.body}\`"
        end
        response
      end

      def get
        resp = http_client.get("#{PATH}/#{id}", headers)
        response.content = if resp.code.to_i == 200
          JSON.parse(resp.body)
        else
          "Failed to get system: \`#{resp.body}\`"
        end
      end

      def results(body)
        JSON.parse(body)['results'].map do |sys|
          sys['id'] = sys['_id']
          sys['ipList'] = sys['networkInterfaces']
            .select { |iface| iface['family'] == 'IPv4' }
            .map { |iface| iface['address'] }
            .join(', ')
          sys
        end
      end

      def id; ENV['COG_OPT_ID']; end
    end
  end
end
