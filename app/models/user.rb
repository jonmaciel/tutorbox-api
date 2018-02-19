class User < ApplicationRecord
  belongs_to :organization, inverse_of: :users
  has_many :videos, foreign_key: :created_by_id

  has_secure_password

  enum user_role: [:admin, :script_writer, :video_producer, :organization_admin, :system_admin, :system_member]
end
