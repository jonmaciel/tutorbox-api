module Resolvers
  module Systems
    module Update
      class << self
        def call(_, input, context)
          system_to_update = System.find(input[:id])

          input[:systemAttributes].to_h.each do |attribute, value|
            system_to_update.send("#{attribute}=", value)
          end

          context[:current_user].authorize!(:update, system_to_update)
          system_to_update.save!

          { system: system_to_update }
        end
      end
    end
  end
end
