module Resolvers
  module Organizations
    module Update
      class << self
        def call(_, input, context)
          organization_to_update = Organization.find(input[:id])

          input[:organizationAttributes].to_h.each do |attribute, value|
            organization_to_update.send("#{attribute}=", value)
          end

          raise 'Not authorized' unless context[:current_user].can?(:update, organization_to_update)

          organization_to_update.save!

          { organization: organization_to_update }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
