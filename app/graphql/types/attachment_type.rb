Types::AttachmentType = GraphQL::ObjectType.define do
  name 'Attachment'

  field :id, types.ID
  field :name, types.String
  field :url, types.String
  field :created_by, Types::UserType
end
