module Resolvers
  module Comments
    module Destroy
      class << self
        def call(_, input, context)
          comment_to_delete = ::Comment.find(input[:id])
          raise 'Not authorized' unless context[:current_user].can?(:destroy, comment_to_delete)

          { success: comment_to_delete.destroy! }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
