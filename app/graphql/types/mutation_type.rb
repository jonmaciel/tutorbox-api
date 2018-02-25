Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createUser, field: UserMutation::Create.field
  field :testField, types.String do
    description "An example field added by the generator"
    resolve ->(obj, args, ctx) {
      "Hello World!"
    }
  end
end
