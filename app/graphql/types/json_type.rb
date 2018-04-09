Types::JsonType = GraphQL::ScalarType.define do
  name 'Json'
  description 'json type'

  coerce_input -> (string_input, _ctx) { Oj.load(string_input) }
  coerce_result -> (hash_output, _ctx) { Oj.dump(hash_output) }
end
