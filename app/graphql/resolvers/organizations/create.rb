module Resolvers
  module Organizations
    module Create
      class << self
        def call(_, input, context)
          input[:userAdminAttributes].try(:delete, :organization_id) if input[:newOrganizationAttributes].present?

          new_organization = Organization.new(input[:newOrganizationAttributes].to_h)
          raise 'Not authorized' unless context[:current_user].can?(:create, new_organization)

          new_organization.users << User.new(input[:userAdminAttributes].to_h) if input[:userAdminAttributes].present?
          new_organization.save!

          { organization: new_organization }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
