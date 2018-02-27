module UserMutation
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateUser'
    description 'Creates a User'

    input_field :newUserAttributes, !UserInput::Attributes, 'User Attributes'
    return_field :user, Types::UserType, 'Returns information about the new user'

    resolve Resolvers::Users::Create
  end


  Update = GraphQL::Relay::Mutation.define do
    name 'UpdateUser'
    description 'Updates a User'

    input_field :id, !types.ID, 'The user ID'
    input_field :userAttributes, !UserInput::Attributes, 'User Attributes'

    return_field :user, Types::UserType, 'Returns information about the user updated'

    resolve Resolvers::Users::Update
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name 'DestroyUser'
    description 'Updates a User'

    input_field :id, !types.ID, 'The user ID'

    return_field :success, types.Boolean, 'Returns operation status'

    resolve Resolvers::Users::Destroy
  end
end
