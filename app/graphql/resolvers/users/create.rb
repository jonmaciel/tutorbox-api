module Resolvers
  module Users
    module Create
      class << self
        def call(_, input, context)
          new_user = User.new(
            name: input[:name],
            email: input[:email],
            password: input[:password],
            password_confirmation: input[:password_confirmation],
            user_role: input[:user_role],
            organization_id: input[:organization_id]
          )

          raise 'Not authorized' unless context[:current_user].can?(:create, new_user)

          new_user.save!

          { user: new_user }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
