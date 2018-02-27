module Resolvers
  module Users
    module Destroy
      class << self
        def call(_, input, context)
          user_to_delete = User.find(input[:id])
          raise 'Not authorized' unless context[:current_user].can?(:destroy, user_to_delete)

          { success: user_to_delete.destroy! }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
