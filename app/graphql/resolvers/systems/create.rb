module Resolvers
  module Systems
    module Create
      class << self
        def call(_, input, context)
          new_system = System.new(input[:newSystemAttributes].to_h)

          raise 'Not authorized' unless context[:current_user].can?(:create, new_system)
          new_system.save!

          { system: new_system }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
