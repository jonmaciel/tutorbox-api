module Resolvers
  module Organizations
    module Update
      class << self
        def call(_, input, context)
          organization_to_update = Organization.find(input[:id])

          input[:organizationAttributes].to_h.each do |attribute, value|
            organization_to_update.send("#{attribute}=", value)
          end

          context[:current_user].authorize!(:update, organization_to_update)

          organization_to_update.save!

          { organization: organization_to_update }
        end
      end
    end
  end
end
