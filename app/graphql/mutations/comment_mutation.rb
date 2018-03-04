module CommentMutation
  Post = GraphQL::Relay::Mutation.define do
    name 'PostComment'
    description 'Post a coment'

    input_field :commentDestination, !MutationEnums::CommentDestinations, 'Comment Destination'
    input_field :body, !types.String, 'Comment body'
    input_field :videoId, !types.ID, 'Comment video id'
    return_field :comment, Types::CommentType, 'Returns information about the new Comment'

    resolve Resolvers::Comments::Post
  end

  Edit = GraphQL::Relay::Mutation.define do
    name 'EditComment'
    description 'Edit a coment'

    input_field :id, !types.ID, 'Comment ID'
    input_field :body, types.String, 'Comment Body'
    input_field :read, types.Boolean, 'Has this comment been read?'
    return_field :comment, Types::CommentType, 'Returns information about the new Comment'

    resolve Resolvers::Comments::Edit
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name 'DestroyComment'
    description 'Updates a Comment'

    input_field :id, !types.ID, 'The Comment ID'

    return_field :success, types.Boolean, 'Returns operation status'

    resolve Resolvers::Comments::Destroy
  end
end
