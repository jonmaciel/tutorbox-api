module Resolvers
  module Organizations
    module Destroy
      class << self
        def call(_, input, context)
          organization_to_delete = Organization.find(input[:id])
          context[:current_user].authorize!(:destroy, organization_to_delete)

          { success: organization_to_delete.destroy! }
        end
      end
    end
  end
end
