module UserInput
  Attributes = GraphQL::InputObjectType.define do
    name 'UserInput'
    description "Users's inputs"

    argument :name, types.String, 'The user name'
    argument :email, types.String, 'The user email'
    argument :cellphone, types.String, 'The user cellphone'
    argument :facebook_url, types.String, 'The user facebook_url'
    argument :password, types.String, 'The user password'
    argument :password_confirmation, types.String, 'The user password_confirmation'
    argument :user_role, MutationEnums::UserRoles, 'The user user_role'
    argument :organization_id, types.ID, 'The organization ID'
    # argument :systems_params, types.ID, 'The system ID'
  end
end
