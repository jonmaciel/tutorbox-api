module Resolvers
  module Attachments
    module Destroy
      class << self
        def call(_, input, context)
          attachment_to_delete = Attachment.find(input[:id])
          context[:current_user].authorize!(:destroy, attachment_to_delete)

          { success: attachment_to_delete.destroy! }
        end
      end
    end
  end
end
