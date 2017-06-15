# frozen_string_literal: true

module JumpCloud
  ##
  ## Contains configuration settings for JumpCloud API
  ##
  class Config
    attr_accessor :api_key

    def initialize(api_key: nil)
      @api_key = api_key
    end
  end
end
