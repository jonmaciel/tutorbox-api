module Resolvers
  module Tasks
    module Destroy
      class << self
        def call(_, input, context)
          task_to_delete = Task.find(input[:id])
          context[:current_user].authorize!(:destroy, task_to_delete)

          { success: task_to_delete.destroy! }
        end
      end
    end
  end
end
