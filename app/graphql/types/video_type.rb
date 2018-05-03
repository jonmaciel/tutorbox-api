Types::VideoType = GraphQL::ObjectType.define do
  name 'Video'

  field :id, types.ID
  field :title, types.String
  field :description, types.String
  field :script, types.String
  field :url, types.String
  field :version, types.String
  field :revised_by_custumer, types.Boolean
  field :aasm_state, types.String
  field :state_verbose, types.String
  field :labels, types[types.String]
  field :created_by, Types::UserType
  field :users, types[Types::UserType]
  field :permited_events, types[types.String]
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType
  field :tasks, types[Types::TaskType]
  field :system, Types::SystemType

  field :comments, types[Types::CommentType] do
    resolve ->(video, _input, context) do
      comments = video.comments.includes(:author)
      comments.where(comment_destination: :customer) if context[:current_user].end_user?
      comments.last(20)
    end
  end
end
