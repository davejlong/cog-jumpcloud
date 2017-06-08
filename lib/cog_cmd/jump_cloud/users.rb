# frozen_string_literal: true

require 'cog/command'

require_relative 'helpers'

module CogCmd
  module JumpCloud
    ##
    ## Commands for working with users
    ##
    class Users < Cog::Command
      include Helpers

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
        response.content = ::JumpCloud::Users.list(jc_config)['results']
        response.template = TEMPLATE
      rescue ::JumpCloud::NetError => e
        response.content = e.message
      end

      def get
        response.content = ::JumpCloud::Users.get(jc_config, id)
      rescue ::JumpCloud::NetError => e
        response.content = e.message
      end

      def create
        response.content = ::JumpCloud::Users
          .create(jc_config, username: username, email: email)
      rescue ::JumpCloud::NetError => e
        response.content = e.message
      end

      private

      def username; ENV['COG_OPT_USERNAME']; end
      def email; ENV['COG_OPT_EMAIL']; end
    end
  end
end
