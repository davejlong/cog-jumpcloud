# frozen_string_literal: true

require 'jump_cloud'

module CogCmd
  module JumpCloud
    ##
    ## Helpers to use for the API
    ##
    module Helpers
      def api_key
        key = ENV.key?('COG_OPT_ACCOUNT') ? "_#{ENV['COG_OPT_ACCOUNT']}" : ''
        ENV["JUMPCLOUD_API_KEY#{key.upcase}"]
      end

      def jc_config
        ::JumpCloud::Config.new(api_key: api_key)
      end

      def subcommand
        request.args.first
      end

      def id; ENV['COG_OPT_ID']; end
    end
  end
end
