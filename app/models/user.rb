class User < ApplicationRecord
  has_secure_password

  belongs_to :user_role

  has_and_belongs_to_many :organizations, inverse_of: :users
  has_many :videos
end
