module VideoMutation
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateVideo'
    description 'Creates a Video'

    input_field :newVideoAttributes, !VideoInput::Attributes, 'Video Attributes'
    return_field :video, Types::VideoType, 'Returns information about the new video'

    resolve Resolvers::Videos::Create
  end

  Update = GraphQL::Relay::Mutation.define do
    name 'UpdateVideo'
    description 'Updates a Video'

    input_field :id, !types.ID, 'The video ID'
    input_field :videoAttributes, !VideoInput::Attributes, 'Video Attributes'

    return_field :video, Types::VideoType, 'Returns information about the video updated'

    resolve Resolvers::Videos::Update
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name 'DestroyVideo'
    description 'Updates a Video'

    input_field :id, !types.ID, 'The video ID'

    return_field :success, types.Boolean, 'Returns operation status'

    resolve Resolvers::Videos::Destroy
  end

  ChangeState = GraphQL::Relay::Mutation.define do
    name 'ChangeStateVideo'
    description 'Change State a Video'

    input_field :videoId, !types.ID, 'The video ID'
    input_field :event, !types.String, 'The video state transition'

    return_field :success, types.Boolean, 'Returns operation status'

    resolve Resolvers::Videos::ChangeState
  end

  Assign = GraphQL::Relay::Mutation.define do
    name 'assignVideo'
    description 'Change State a Video'

    input_field :videoId, !types.ID, 'The video ID'
    input_field :userId, !types.ID, 'The user ID'

    return_field :success, types.Boolean, 'Returns operation status'

    resolve Resolvers::Videos::Assign
  end

  Unassign = GraphQL::Relay::Mutation.define do
    name 'unassignVideo'
    description 'Change State a Video'

    input_field :videoId, !types.ID, 'The video ID'
    input_field :userId, !types.ID, 'The user ID'

    return_field :success, types.Boolean, 'Returns operation status'

    resolve Resolvers::Videos::Unassign
  end
end
