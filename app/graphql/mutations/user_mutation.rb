module UserMutation
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateUser'
    description 'Creates a User'

    input_field :new_user_attributes, !UserInput::Attributes, 'User Attributes'
    return_field :user, Types::UserType, 'Returns information about the new user'

    resolve Resolvers::Users::Create
  end


  Update = GraphQL::Relay::Mutation.define do
    name 'UpdateUser'
    description 'Updates a User'

    input_field :id, !types.ID, 'The user ID'
    input_field :user_attributes, !UserInput::Attributes, 'User Attributes'

    return_field :user, Types::UserType, 'Returns information about the new user'

    resolve Resolvers::Users::Update
  end
end
