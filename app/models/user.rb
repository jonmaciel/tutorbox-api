class User < ApplicationRecord
  belongs_to :organization, inverse_of: :users
  has_many :videos, foreign_key: :created_by_id

  acts_as_paranoid
  has_secure_password

  enum user_role: [:admin, :script_writer, :video_producer, :organization_admin, :system_admin, :system_member]

  validates :name, :email, :user_role, :password_digest,  presence: true

  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  delegate :can?, to: :access_policy

  before_validation :create_random_password, on: :create, if: :end_user?
  before_validation :send_welcome_email, on: :create

  END_USER = ['organization_admin', 'system_admin', 'system_member']

  User.user_roles.keys.each do |role|
    define_method("#{role}?") do
      user_role == role
    end
  end

  def end_user?
    user_role.in?(END_USER)
  end

  def access_policy
    @access_policy ||= AccessPolicy.new(self)
  end

  def create_random_password
    self.password = self.password_confirmation = SecureRandom.hex(8) if password.blank?
    true
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
