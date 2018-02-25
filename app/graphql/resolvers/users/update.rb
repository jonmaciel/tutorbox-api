module Resolvers
  module Users
    module Update
      class << self
        def call(_, input, context)
          user_to_update = User.find(input[:id])

          input[:user_attributes].to_h.each do |attribute, value|
            user_to_update.send("#{attribute}=", value)
          end

          raise 'Not authorized' unless context[:current_user].can?(:update, user_to_update)

          user_to_update.save!

          { user: user_to_update }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
