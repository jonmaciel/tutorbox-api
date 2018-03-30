module Resolvers
  module Comments
    module Edit
      class << self
        def call(_, input, context)
          comment_to_update = Comment.find(input[:id])

          comment_to_update.body = input[:body] if input[:body].present?
          comment_to_update.read = input[:read] if input[:read].present?

          context[:current_user].authorize!(:post, comment_to_update)
          comment_to_update.save!

          { comment: comment_to_update }
        end
      end
    end
  end
end
