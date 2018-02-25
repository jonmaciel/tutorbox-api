Types::UserType = GraphQL::ObjectType.define do
  name "User"

  field :id, types.ID
  field :name, types.String
  field :email, types.String
  field :cellphone, types.String
  field :facebook_url, types.String
  field :user_role, types.String
  field :system_role_params, types.String
  field :organization, Types::OrganizationType
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
end
