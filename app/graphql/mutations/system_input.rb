module SystemInput
  Attributes = GraphQL::InputObjectType.define do
    name 'SystemInput'
    description "Users's inputs"

    argument :name, types.String, 'The System name'
    argument :organization_id, types.ID, 'The System name'
  end
end
