class User < ApplicationRecord
  has_secure_password

  belongs_to :user_role

  belongs_to :organization, inverse_of: :users
  has_many :videos, foreign_key: :created_by_id
end
