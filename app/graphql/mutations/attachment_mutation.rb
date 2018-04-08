module AttachmentMutation
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateAttachment'
    description 'Creates a Attachment'

    input_field :sourceId, !types.ID, 'Source ID'
    input_field :name, types.String, 'Attachment name'
    input_field :url, !types.String, 'Attachment url'
    return_field :attachment, Types::AttachmentType, 'Returns information about the new attachment'

    resolve Resolvers::Attachments::Create
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name 'DestroyAttachment'
    description 'Updates a Attachment'

    input_field :id, !types.ID, 'The Attachment ID'

    return_field :success, types.Boolean, 'Returns operation status'

    resolve Resolvers::Attachments::Destroy
  end
end
