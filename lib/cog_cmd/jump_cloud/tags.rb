# frozen_string_literal: true

require 'cog/command'
require 'json'

require_relative 'helpers'

module CogCmd
  module JumpCloud
    ##
    ## Commands for working with Tags
    ##
    class Tags < Cog::Command
      include Helpers

      PATH = "#{BASE_PATH}/tags"
      TEMPLATE = 'tags'

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
          response.template = TEMPLATE
          response.content = results(resp.body)
        else
          response.content = "Failed to get tags: \`#{resp.body}\`"
        end
        response
      end

      def get
        resp = http_client.get("#{PATH}/#{id}", headers)
        response.content = if resp.code.to_i == 200
          JSON.parse(resp.body)
        else
          "Failed to get tag: \`#{resp.body}\`"
        end
      end

      def id; ENV['COG_OPT_ID']; end
    end
  end
end
