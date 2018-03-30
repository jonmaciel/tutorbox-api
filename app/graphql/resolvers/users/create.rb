module Resolvers
  module Users
    module Create
      class << self
        def call(_, input, context)
          new_user = User.new(input[:newUserAttributes].to_h)

          context[:current_user].authorize!(:create, new_user)

          new_user.save!

          { user: new_user }
        end
      end
    end
  end
end
