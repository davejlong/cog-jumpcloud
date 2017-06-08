# frozen_string_literal: true

require 'cog/command'

require_relative 'helpers'

module CogCmd
  module JumpCloud
    ##
    ## Commands for working with systems
    ##
    class Systems < Cog::Command
      include Helpers

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
        response.content = ::JumpCloud::Systems.list(jc_config)['results'].map do |sys|
          sys['ipList'] = sys['networkInterfaces']
            .select { |iface| iface['family'] == 'IPv4' }
            .map { |iface| iface['address'] }
            .join(', ')
          sys
        end
        response.template = TEMPLATE
      rescue ::JumpCloud::NetError => e
        response.content = e.message
      end

      def get
        response.content = ::JumpCloud::Systems.get(jc_config, id)
      rescue ::JumpCloud::NetError => e
        response.content = e.message
      end
    end
  end
end
