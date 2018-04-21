Types::VideoNotificationType = GraphQL::ObjectType.define do
  name 'VideoNotification'

  field :id, types.ID
  field :body, types.String
  field :read, types.Boolean
  field :video, Types::VideoType
  field :user, Types::UserType
end
