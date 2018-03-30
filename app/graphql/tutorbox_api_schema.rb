TutorboxApiSchema = GraphQL::Schema.define do
  mutation(Types::MutationType)
  query(Types::QueryType)
end

GraphQL::Errors.configure(TutorboxApiSchema) do
  rescue_from ActiveRecord::RecordInvalid do |e|
    messages = e.record.errors.full_messages.join("\n")
    GraphQL::ExecutionError.new "Validation failed: #{messages}."
  end

  rescue_from Exceptions::PermissionDeniedError do |e|
    GraphQL::ExecutionError.new(e.message)
  end

  rescue_from Exceptions::NotPermittedEvent do |e|
    GraphQL::ExecutionError.new(e.message)
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    GraphQL::ExecutionError.new(e.message.split(' [').first)
  end

  rescue_from GraphQL::ExecutionError do |e|
    GraphQL::ExecutionError.new(e.message)
  end
end