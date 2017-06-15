# frozen_string_literal: true

require 'cog/command'
require_relative 'helpers'

module CogCmd
  module JumpCloud
    ##
    ## Commands for working with Tags
    ##
    class Tags < Cog::Command
      include Helpers

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
        response.content = ::JumpCloud::Tags
          .list(jc_config, limit: limit, skip: skip)['results']
        response.template = TEMPLATE
      rescue ::JumpCloud::NetError => e
        response.content = e.message
      end

      def get
        response.content = ::JumpCloud::Tags.get(jc_config, id)
      rescue ::JumpCloud::NetError => e
        response.content = e.message
      end
    end
  end
end
