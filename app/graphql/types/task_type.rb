Types::TaskType = GraphQL::ObjectType.define do
  name 'Task'

  field :id, types.ID
  field :name, types.String
  field :done, types.Boolean
  field :created_by, Types::UserType
end
