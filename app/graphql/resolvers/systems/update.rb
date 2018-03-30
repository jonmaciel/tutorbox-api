module Resolvers
  module Systems
    module Update
      class << self
        def call(_, input, context)
          system_to_update = Task.find(input[:id])

          system_to_update.name = input[:name] if input[:name].present?

          context[:current_user].authorize!(:update, system_to_update)
          system_to_update.save!

          { system: system_to_update }
        end
      end
    end
  end
end
