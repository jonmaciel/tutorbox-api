module OrganizationMutation
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateUser'
    description 'Creates a Organization'

    input_field :newOrganizationAttributes, !OrganizationInput::Attributes, 'Organization Attributes'
    input_field :userAdminAttributes, UserInput::Attributes, 'User Attributes'
    return_field :organization, Types::OrganizationType, 'Returns information about the new Organization'

    resolve Resolvers::Organizations::Create
  end


  Update = GraphQL::Relay::Mutation.define do
    name 'UpdateOrganization'
    description 'Updates a Organization'

    input_field :id, !types.ID, 'The Organization ID'
    input_field :organizationAttributes, !OrganizationInput::Attributes, 'Organization Attributes'

    return_field :organization, Types::OrganizationType, 'Returns information about the Organization updated'

    resolve Resolvers::Organizations::Update
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name 'DestroyOrganization'
    description 'Updates a Organization'

    input_field :id, !types.ID, 'The Organization ID'

    return_field :success, types.Boolean, 'Returns operation status'

    resolve Resolvers::Organizations::Destroy
  end
end
