Types::OrganizationType = GraphQL::ObjectType.define do
  name "Organization"

  field :id, types.ID
  field :name, types.String
  field :users, types[Types::UserType]
  field :systems, types[Types::SystemType]
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
end
