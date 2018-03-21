module SystemMutation
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateSystem'
    description 'Creates a system'

    input_field :newSystemAttributes, !SystemInput::Attributes, 'system Attributes'
    return_field :system, Types::SystemType, 'Returns information about the new system'

    resolve Resolvers::Systems::Create
  end


  Update = GraphQL::Relay::Mutation.define do
    name 'UpdateSystem'
    description 'Updates a System'

    input_field :id, !types.ID, 'The system ID'
    input_field :systemAttributes, !SystemInput::Attributes, 'System Attributes'

    return_field :system, Types::SystemType, 'Returns information about the System updated'

    resolve Resolvers::Systems::Update
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name 'DestroySystem'
    description 'destroy a system'

    input_field :id, !types.ID, 'The system ID'

    return_field :success, types.Boolean, 'Returns operation status'

    resolve Resolvers::Systems::Destroy
  end
end
