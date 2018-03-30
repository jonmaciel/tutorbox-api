module Exceptions
  class PermissionDeniedError < StandardError
    def initialize
      super('Permission denied')
    end
  end
end
