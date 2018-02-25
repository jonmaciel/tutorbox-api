module Resolvers
  module Users
    module Create
      class << self
        def call(_, input, context)
          new_user = User.new(input[:new_user_attributes].to_h)

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
