module Resolvers
  module Tasks
    module Update
      class << self
        def call(_, input, context)
          task_to_update = Task.find(input[:id])

          task_to_update.name = input[:name] if input[:name].present?
          task_to_update.done = input[:done] if input[:done].present?

          context[:current_user].authorize!(:update, task_to_update)
          task_to_update.save!

          { task: task_to_update }
        end
      end
    end
  end
end
