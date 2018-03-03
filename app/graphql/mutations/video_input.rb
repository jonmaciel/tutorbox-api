module VideoInput
  Attributes = GraphQL::InputObjectType.define do
    name 'VideoInput'
    description "Video's inputs"

    argument :title, types.String, 'The video title'
    argument :description, types.String, 'The video description'
    argument :url, types.String, 'The video URL'
    argument :labels, types[types.String], 'Labels'
    argument :system_id, types.ID, 'The video ID'
  end
end