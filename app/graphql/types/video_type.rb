Types::VideoType = GraphQL::ObjectType.define do
  name 'Video'

  field :id, types.ID
  field :title, types.String
  field :url, types.String
  field :aasm_state, types.String
  field :labels, types[types.String]
  field :created_by, Types::UserType
  field :permited_events, types[types.String]
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
  field :tasks, types[Types::TaskType]

  field :comments, types[Types::CommentType] do
    resolve ->(video, _input, context) do
      comments = video.comments
      comments.where(comment_destination: :customer) if context[:current_user].end_user?
      comments
    end
  end
end
