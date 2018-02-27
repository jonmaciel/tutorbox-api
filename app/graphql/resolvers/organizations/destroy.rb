module Resolvers
  module Organizations
    module Destroy
      class << self
        def call(_, input, context)
          organization_to_delete = Organization.find(input[:id])
          raise 'Not authorized' unless context[:current_user].can?(:destroy, organization_to_delete)

          { success: organization_to_delete.destroy! }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
