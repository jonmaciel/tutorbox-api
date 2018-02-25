module UserMutation
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateUser'
    description 'Creates a User'

    input_field :name, !types.String, 'The user name'
    input_field :email, types.ID, 'The user email'
    input_field :password, types.ID, 'The user password'
    input_field :password_confirmation, types.ID, 'The user password_confirmation'
    input_field :user_role, types.ID, 'The user user_role'
    input_field :organization_id, types.ID, 'The organization ID'
    # input_field :systems_params, types.ID, 'The system ID'

    return_field :user, Types::UserType, 'Returns information about the new user'

    resolve Resolvers::Users::Create
  end
end
