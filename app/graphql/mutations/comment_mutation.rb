module CommentMutation
  Post = GraphQL::Relay::Mutation.define do
    name 'PostComment'
    description 'Post a coment'

    input_field :commentDestination, !MutationEnums::CommentDestinations, 'Comment Destination'
    input_field :body, !types.String, 'User Attributes'
    input_field :videoId, !types.ID, 'User Attributes'
    return_field :comment, Types::CommentType, 'Returns information about the new user'

    resolve Resolvers::Comments::Post
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name 'DestroyComment'
    description 'Updates a User'

    input_field :id, !types.ID, 'The user ID'

    return_field :success, types.Boolean, 'Returns operation status'

    resolve Resolvers::Comments::Destroy
  end
end
