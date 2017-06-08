# frozen_string_literal: true

require 'cog/command'

require_relative 'helpers'

module CogCmd
  module JumpCloud
    ##
    ## Commands for working with Commands
    ##
    class Commands < Cog::Command
      include Helpers

      TEMPLATE = 'commands'

      def run_command
        case subcommand
        when 'list', nil
          list
        when 'get'
          get
        end
      end

      def list
        response.content = ::JumpCloud::Commands.list(jc_config)['results']
        response.template = TEMPLATE
      rescue ::JumpCloud::NetError => e
        response.content = e.message
      end

      def get
        response.content = ::JumpCloud::Commands.get(jc_config, id)
      rescue ::JumpCloud::NetError => e
        response.content = e.message
      end

      private

      def id; ENV['COG_OPT_ID']; end
    end
  end
end
