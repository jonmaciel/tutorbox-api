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

          context[:current_user].authorize!(:post, new_comment)
          new_comment.save!

          { comment: new_comment }
        end
      end
    end
  end
end
