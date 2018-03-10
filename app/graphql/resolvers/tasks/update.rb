module Resolvers
  module Tasks
    module Update
      class << self
        def call(_, input, context)
          task_to_update = Task.find(input[:id])

          task_to_update.name = input[:name] if input[:name].present?
          task_to_update.done = input[:done] if input[:done].present?

          raise 'Not authorized' unless context[:current_user].can?(:update, task_to_update)
          task_to_update.save!

          { task: task_to_update }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
