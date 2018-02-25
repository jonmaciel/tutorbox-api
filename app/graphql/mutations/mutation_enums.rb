module MutationEnums
  UserRoles = GraphQL::EnumType.define do
    name 'UserRoles'
    description 'User role options#!/usr/bin/env ruby -wKU'

    User.user_roles.keys.each do |role|
      value role.camelize(:lower), role.titleize, value: role
    end
  end
end
