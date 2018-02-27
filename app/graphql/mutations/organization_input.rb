module OrganizationInput
  Attributes = GraphQL::InputObjectType.define do
    name 'OrganizationInput'
    description "Users's inputs"

    argument :name, types.String, 'The organization name'
  end
end
