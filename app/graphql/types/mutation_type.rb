Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createUser, field: UserMutation::Create.field
  field :updateUser, field: UserMutation::Update.field
  field :destroyUser, field: UserMutation::Destroy.field

  field :createVideo, field: VideoMutation::Create.field
  field :updateVideo, field: VideoMutation::Update.field
  field :destroyVideo, field: VideoMutation::Destroy.field
  field :changeVideoState, field: VideoMutation::ChangeState.field
end
