module Exceptions
  class NotPermittedEvent < StandardError
    def initialize
      super('Not permitted event')
    end
  end
end
