module Resolvers
  module Systems
    module Destroy
      class << self
        def call(_, input, context)
          system_to_delete = System.find(input[:id])
          context[:current_user].authorize!(:destroy, system_to_delete)

          { success: system_to_delete.destroy! }
        end
      end
    end
  end
end
