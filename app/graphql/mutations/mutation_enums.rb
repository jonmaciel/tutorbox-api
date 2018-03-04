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
end
