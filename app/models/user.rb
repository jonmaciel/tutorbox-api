class User < ApplicationRecord
  belongs_to :organization, inverse_of: :users
  has_many :videos, foreign_key: :created_by_id

  has_secure_password

  enum user_role: [:admin, :script_writer, :video_producer, :organization_admin, :system_admin, :system_member]

  validates :name, :email, :user_role, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  delegate :can?, to: :access_policy

  User.user_roles.keys.each do |role|
    define_method("#{role}?") do
      user_role == role
    end
  end

  def access_policy
    @access_policy ||= AccessPolicy.new(self)
  end
end
