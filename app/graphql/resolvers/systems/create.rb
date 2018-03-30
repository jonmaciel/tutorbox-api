module Resolvers
  module Systems
    module Create
      class << self
        def call(_, input, context)
          new_system = System.new(input[:newSystemAttributes].to_h)

          context[:current_user].authorize!(:create, new_system)
          new_system.save!

          { system: new_system }
        end
      end
    end
  end
end
