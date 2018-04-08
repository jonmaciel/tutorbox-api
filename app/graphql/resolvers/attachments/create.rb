module Resolvers
  module Attachments
    module Create
      class << self
        def call(_, input, context)
          new_attachment = Attachment.new(
            name: input[:name],
            url: input[:url],
            source_id: input[:sourceId],
            source_type: Video,
            created_by: context[:current_user]
          )

          context[:current_user].authorize!(:create, new_attachment)
          new_attachment.save!

          { attachment: new_attachment }
        end
      end
    end
  end
end
