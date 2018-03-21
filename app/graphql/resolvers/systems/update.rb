module Resolvers
  module Systems
    module Update
      class << self
        def call(_, input, context)
          system_to_update = Task.find(input[:id])

          system_to_update.name = input[:name] if input[:name].present?

          raise 'Not authorized' unless context[:current_user].can?(:update, system_to_update)
          system_to_update.save!

          { system: system_to_update }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
