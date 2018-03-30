class User < ApplicationRecord
  belongs_to :organization, inverse_of: :users, optional: true
  belongs_to :system, inverse_of: :users, optional: true
  has_many :created_videos, foreign_key: :created_by_id, class_name: 'Video'
  has_and_belongs_to_many :videos, inverse_of: :users

  acts_as_paranoid
  has_secure_password

  enum user_role: [:admin, :script_writer, :video_producer, :organization_admin, :system_admin, :system_member]

  validates :name, :email, :user_role, :password_digest,  presence: true

  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, uniqueness: true

  before_validation :create_random_password, on: :create, if: -> { password.blank? }
  before_validation :send_welcome_email, on: :create

  scope :tutormakers, -> { where.not(user_role: END_USER) }
  scope :end_users, -> { where(user_role: END_USER) }

  delegate :can?, to: :access_policy

  END_USER = ['organization_admin', 'system_admin', 'system_member'].freeze

  def authorize!(role, obj)
    return true if can?(role, obj)
    raise Exceptions::PermissionDeniedError.new
  end

  def end_user?
    user_role.in?(END_USER)
  end

  def access_policy
    @access_policy ||= AccessPolicy.new(self)
  end

  def create_random_password
    self.password = self.password_confirmation = SecureRandom.hex(8)
    true
  end

  private

  def send_welcome_email
    # UserMailer.welcome_email(self).deliver
    true
  end
end
