FactoryBot.define do
  factory :user do
    name 'User Test'
    email 'test@mail.com'
    password '123123123'
    association :user_role
  end
end
