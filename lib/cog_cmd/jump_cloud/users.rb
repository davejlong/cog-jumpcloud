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
    class Users < Cog::Command
      include Helpers

      PATH = "#{BASE_PATH}/systemusers"
      TEMPLATE = 'users'

      def run_command
        case subcommand
        when 'list', nil
          list
        when 'create'
          create
        end
      end

      def list
        resp = http_client.get(PATH, headers)
        if resp.code.to_i == 200
          response.content = parse_body(resp.body)
          response.template = TEMPLATE
        else
          response.content = "Failed to get users: \`#{resp.body}\`"
        end
        response
      end

      def create
        resp = http_client.post(PATH, body.to_json, headers)
        if resp.code.to_i == 200
          response.content = [JSON.parse(resp.body)]
          response.template = TEMPLATE
        else
          response.content = "Failed to create user: \`#{resp.body}\`."
        end
        response
      end

      def body
        {
          username: ENV['COG_OPT_USERNAME'],
          email: ENV['COG_OPT_EMAIL']
        }
      end

      def parse_body(body)
        JSON.parse(body)['results']
      end
    end
  end
end
