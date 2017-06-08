require_relative 'base'

module JumpCloud
  ##
  ## Commands API Resource
  ##
  class CommandResults < Base
    PATH = "#{BASE_PATH}/commandresults"

    private

    def path; PATH; end
  end
end
