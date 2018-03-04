module Resolvers
  module Comments
    module Post
      class << self
        def call(_, input, context)
          new_comment = ::Comment.new(
            comment_destination: input[:commentDestination],
            body: input[:body],
            video_id: input[:videoId],
            author: context[:current_user]
          )

          raise 'Not authorized' unless context[:current_user].can?(:post, new_comment)
          new_comment.save!

          { comment: new_comment }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
