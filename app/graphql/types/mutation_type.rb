Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createUser, field: UserMutation::Create.field
  field :updateUser, field: UserMutation::Update.field
  field :destroyUser, field: UserMutation::Destroy.field
end
