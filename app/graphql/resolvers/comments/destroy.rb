module Resolvers
  module Comments
    module Destroy
      class << self
        def call(_, input, context)
          comment_to_delete = Comment.find(input[:id])

          context[:current_user].authorize!(:destroy, comment_to_delete)

          { success: comment_to_delete.destroy! }
        end
      end
    end
  end
end
