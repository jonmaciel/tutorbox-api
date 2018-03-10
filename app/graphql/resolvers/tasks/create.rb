module Resolvers
  module Tasks
    module Create
      class << self
        def call(_, input, context)
          new_comment = Task.new(
            name: input[:name],
            video_id: input[:videoId],
            created_by: context[:current_user]
          )

          raise 'Not authorized' unless context[:current_user].can?(:create, new_comment)
          new_comment.save!

          { task: new_comment }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
