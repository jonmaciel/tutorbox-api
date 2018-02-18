FactoryBot.define do
  factory :video do
    title 'test'
    description 'Video test'
    labels ['teste']
    association :system
    association :created_by, factory: :user
  end
end
