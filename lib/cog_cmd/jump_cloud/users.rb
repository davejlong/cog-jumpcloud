# frozen_string_literal: true

require 'cog/command'
require 'json'

require_relative 'helpers'

module CogCmd
  module JumpCloud
    ##
    ## Commands for working with users
    ##
    class Users < Cog::Command
      include Helpers

      PATH = "#{BASE_PATH}/systemusers"
      TEMPLATE = 'users'

      def run_command
        case subcommand
        when 'list', nil
          list
        when 'get'
          get
        when 'create'
          create
        end
      end

      def list
        resp = http_client.get(PATH, headers)
        if resp.code.to_i == 200
          response.content = results(resp.body)
          response.template = TEMPLATE
        else
          response.content = "Failed to get users: \`#{resp.body}\`"
        end
        response
      end

      def get
        resp = http_client.get("#{PATH}/#{id}", headers)
        response.content = if resp.code.to_i == 200
          JSON.parse(resp.body)
        else
          "Failed to get user: \`#{resp.body}\`"
        end
      end

      def create
        resp = http_client.post(PATH, body.to_json, headers)
        response.content = if resp.code.to_i == 200
          [JSON.parse(resp.body)]
        else
          "Failed to create user: \`#{resp.body}\`."
        end
      end

      def body
        {
          username: ENV['COG_OPT_USERNAME'],
          email: ENV['COG_OPT_EMAIL']
        }
      end

      def id; ENV['COG_OPT_ID']; end
    end
  end
end
