module Exceptions
  class NotPermittedEvent < StandardError
    def initialize(msg = nil)
      super(msg  || 'Not permitted event')
    end
  end
end
