Types::S3Type = GraphQL::ObjectType.define do
  name 'S3'

  field :signedUrl, types.String do
    resolve ->(obj, _input, context) do
      obj[:signed_url]
    end
  end

  field :fileName, types.String do
    resolve ->(obj, _input, context) do
      obj[:file_name]
    end
  end
end
