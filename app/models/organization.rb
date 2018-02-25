class
  Organization < ApplicationRecord
  has_many :systems
  has_and_belongs_to_many :users, inverse_of: :organizations

  acts_as_paranoid
end
