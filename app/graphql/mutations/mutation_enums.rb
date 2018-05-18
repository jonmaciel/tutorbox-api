module MutationEnums
  UserRoles = GraphQL::EnumType.define do
    name 'UserRoles'
    description 'User role options'

    User.user_roles.each_key do |role|
      value role.camelize(:lower), role.titleize, value: role
    end
  end

  CommentDestinations = GraphQL::EnumType.define do
    name 'CommentDestinations'
    description 'Comment destination role options'

    Comment.comment_destinations.each_key do |destination|
      value destination.camelize(:lower), destination.titleize, value: destination
    end
  end

  VideoUploadTypes = GraphQL::EnumType.define do
    name 'VideoUploadTypes'
    description 'Video Upload Type'

    Video.upload_types.each_key do |upload_type|
      value upload_type.camelize(:lower), upload_type.titleize, value: upload_type
    end
  end
end
