module TaskMutation
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateTask'
    description 'Create a task'

    input_field :name, !types.String, 'Task body'
    input_field :videoId, !types.ID, 'Task video id'

    return_field :task, Types::TaskType, 'Returns information about the new Task'

    resolve Resolvers::Tasks::Create
  end

  Update = GraphQL::Relay::Mutation.define do
    name 'UpdateComment'
    description 'Update a coment'

    input_field :id, !types.ID, 'Task ID'
    input_field :name, types.String, 'Task Name'
    input_field :done, types.Boolean, 'Has this task been done?'

    return_field :task, Types::TaskType, 'Returns information about the new Task'

    resolve Resolvers::Tasks::Update
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name 'DestroTask'
    description 'Updates a Task'

    input_field :id, !types.ID, 'The Task ID'

    return_field :success, types.Boolean, 'Returns operation status'

    resolve Resolvers::Tasks::Destroy
  end
end
