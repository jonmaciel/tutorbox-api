Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createUser, field: UserMutation::Create.field
  field :updateUser, field: UserMutation::Update.field
  field :destroyUser, field: UserMutation::Destroy.field

  field :createVideo, field: VideoMutation::Create.field
  field :updateVideo, field: VideoMutation::Update.field
  field :destroyVideo, field: VideoMutation::Destroy.field
  field :changeVideoState, field: VideoMutation::ChangeState.field
  field :assignVideo, field: VideoMutation::Assign.field
  field :unassignVideo, field: VideoMutation::Unassign.field

  field :postComment, field: CommentMutation::Post.field
  field :editComment, field: CommentMutation::Edit.field
  field :destroyComment, field: CommentMutation::Destroy.field
end
