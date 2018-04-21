Types::UserType = GraphQL::ObjectType.define do
  name 'User'

  field :id, types.ID
  field :name, types.String
  field :email, types.String
  field :cellphone, types.String
  field :facebook_url, types.String
  field :user_role, types.String do
    resolve ->(user, _, _) { user.user_role.camelize(:lower) }
  end
  field :system, Types::SystemType
  field :organization, Types::OrganizationType
  field :videoNotifications, types[Types::VideoNotificationType]
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
end
