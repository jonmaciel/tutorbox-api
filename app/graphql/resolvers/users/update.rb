module Resolvers
  module Users
    module Update
      class << self
        def call(_, input, context)
          user_to_update = User.find(input[:id])

          input[:userAttributes].to_h.each do |attribute, value|
            user_to_update.send("#{attribute}=", value)
          end

          context[:current_user].authorize!(:update, user_to_update)

          user_to_update.save!

          { user: user_to_update }
        end
      end
    end
  end
end
