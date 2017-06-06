#!/usr/bin/env ruby
# frozen_string_literal: true

require 'cog/command'

require_relative 'helpers'

module CogCmd
  module JumpCloud
    ##
    ## Looks up what accounts are available
    ##
    class Accounts < Cog::Command
      include Helpers

      def run_command
        response.content = if accounts.empty?
          'No accounts configured.'
        else
          accounts
            .map { |account| "* #{account}" }
            .join("\n")
        end
      end

      def accounts
        ENV
          .select { |key, _v| key =~ /JUMPCLOUD_API_KEY_/ }
          .map { |key, _v| key.gsub(/JUMPCLOUD_API_KEY_/, '').downcase }
      end
    end
  end
end
