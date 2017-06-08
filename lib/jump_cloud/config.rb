module JumpCloud
  class Config
    attr_accessor :api_key

    def initialize(api_key: nil)
      @api_key = api_key
    end
  end
end
