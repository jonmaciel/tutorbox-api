module Resolvers
  module Tasks
    module Destroy
      class << self
        def call(_, input, context)
          task_to_destroy = Task.find(input[:id])
          raise 'Not authorized' unless context[:current_user].can?(:destroy, task_to_destroy)

          { success: task_to_destroy.destroy! }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
