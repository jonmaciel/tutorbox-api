module Exceptions
  class ResourceNotFoundError < StandardError
    def initialize(message)
      super(message)
    end
  end
end
