module Resolvers
  module Systems
    module Destroy
      class << self
        def call(_, input, context)
          system_to_delete = System.find(input[:id])
          raise 'Not authorized' unless context[:current_user].can?(:destroy, system_to_delete)

          { success: system_to_delete.destroy! }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
