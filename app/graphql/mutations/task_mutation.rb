module TaskMutation
  Create = GraphQL::Relay::Mutation.define do
    name 'EditTask'
    description 'Post a coment'

    input_field :name, !types.String, 'Task body'
    input_field :videoId, !types.ID, 'Task video id'

    return_field :task, Types::TaskType, 'Returns information about the new Task'

    resolve Resolvers::Tasks::Create
  end

  Update = GraphQL::Relay::Mutation.define do
    name 'UpdateTask'
    description 'Edit a coment'

    input_field :id, !types.ID, 'Task ID'
    input_field :name, types.String, 'Task name'
    input_field :done, types.Boolean, 'Has this Task been done?'
    return_field :task, Types::TaskType, 'Returns information about the new Task'

    resolve Resolvers::Tasks::Update
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name 'DestroyTask'
    description 'Updates a Task'

    input_field :id, !types.ID, 'The Task ID'

    return_field :success, types.Boolean, 'Returns operation status'

    resolve Resolvers::Tasks::Destroy
  end
end
