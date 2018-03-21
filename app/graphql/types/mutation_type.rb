Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createSystem, field: SystemMutation::Create.field
  field :updateSystem, field: SystemMutation::Update.field
  field :destroySystem, field: SystemMutation::Destroy.field

  field :createOrganization, field: OrganizationMutation::Create.field
  field :updateOrganization, field: OrganizationMutation::Update.field
  field :destroyOrganization, field: OrganizationMutation::Destroy.field

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

  field :createTask, field: TaskMutation::Create.field
  field :updateTask, field: TaskMutation::Update.field
  field :destroyTask, field: TaskMutation::Destroy.field
end
