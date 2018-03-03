class Organization < ApplicationRecord
  has_many :systems, inverse_of: :organization
  has_many :users, inverse_of: :organization

  acts_as_paranoid
end
