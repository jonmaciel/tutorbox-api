Types::CommentType = GraphQL::ObjectType.define do
  name "Comment"

  field :id, types.ID
  field :author, Types::UserType
  field :comment_destination, types.String
  field :body, types.String
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
end



