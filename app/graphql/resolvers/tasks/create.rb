module Resolvers
  module Tasks
    module Create
      class << self
        def call(_, input, context)
          new_task = Task.new(
            name: input[:name],
            video_id: input[:videoId],
            created_by: context[:current_user]
          )

          raise 'Not authorized' unless context[:current_user].can?(:create, new_task)
          new_task.save!

          { task: new_task }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
