Types::SystemType = GraphQL::ObjectType.define do
  name 'System'

  field :id, types.ID
  field :name, types.String
  field :organization, Types::OrganizationType
  field :videos, types[Types::VideoType]
end
