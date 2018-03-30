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

          context[:current_user].authorize!(:create, new_comment)
          new_comment.save!

          { task: new_comment }
        end
      end
    end
  end
end
