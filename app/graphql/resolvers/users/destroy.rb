module Resolvers
  module Users
    module Destroy
      class << self
        def call(_, input, context)
          user_to_delete = User.find(input[:id])
          context[:current_user].authorize!(:destroy, user_to_delete)

          { success: user_to_delete.destroy! }
        end
      end
    end
  end
end
