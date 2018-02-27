FactoryBot.define do
  factory :user do
    name 'User Test'
    email 'test@mail.com'
     association :organization
  end
end
