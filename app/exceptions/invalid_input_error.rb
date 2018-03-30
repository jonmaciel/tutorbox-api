module Exceptions
  class InvalidInputError < StandardError
    INVALID_INPUT = 'Invalid input: %s (%s)'.freeze
    private_constant :INVALID_INPUT

    def initialize(input, value)
      super format(INVALID_INPUT, input, value)
    end
  end
end
