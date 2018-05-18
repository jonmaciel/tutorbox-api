class Video < ApplicationRecord
  include AASM

  acts_as_paranoid

  belongs_to :system
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id
  has_many :comments
  has_many :tasks
  has_many :state_histories
  has_many :attachments, as: :source, inverse_of: :source
  has_many :notifications, inverse_of: :video, class_name: 'VideoNotification'
  has_and_belongs_to_many :users, inverse_of: :videos

  enum upload_type: [:aws, :url]

  def state_verbose
    I18n.t("video.state.#{aasm_state}")
  end

  def authorize_event!(event)
    return true if permited_events.include?(event)
    raise Exceptions::NotPermittedEvent.new
  end

  aasm do
    state :canceled
    state :draft, initial: true
    state :script_creation
    state :waiting_for_production
    state :production
    state :screenwriter_revision
    state :customer_revision
    state :approved

    after_all_transitions :log_status_change

    event :cancel_video do
      transitions from: [:draft], to: :canceled
    end

    event :send_request, after: [:increase_version, :send_notifications] do
      transitions from: [:draft], to: :script_creation, guard: :description_present?
    end

    event :cancel_request do
      transitions from: [:script_creation], to: :draft
    end

    event :send_to_production, after: [:increase_version, :send_notifications] do
      transitions from: [:script_creation], to: :waiting_for_production
    end

    event :cancel_production_request do
      transitions from: [:waiting_for_production], to: :script_creation
    end

    event :accept_production, after: [:increase_version, :send_notifications] do
      transitions from: [:waiting_for_production], to: :production
    end

    event :cancel_production do
      transitions from: [:production], to: :waiting_for_production
    end

    event :send_to_screenwriter_revision, after: [:increase_version, :send_notifications] do
      transitions from: [:production], to: :screenwriter_revision
    end

    event :refused_by_screenwriter do
      transitions from: [:screenwriter_revision], to: :waiting_for_production
    end

    event :send_to_customer_revision, after: [:increase_version, :send_notifications, :revised_by_custumer!] do
      transitions from: [:screenwriter_revision], to: :customer_revision
    end

    event :refused_by_customer do
      transitions from: [:customer_revision], to: :screenwriter_revision
    end

    event :approved_by_customer do
      transitions from: [:customer_revision], to: :approved
    end
  end

  def permited_events
    aasm.events(permitted: true).map(&:name)
  end

  def url
    aws? && super.present? ? "https://s3.us-east-2.amazonaws.com/tutorbox-files/#{super}" : super
  end

  private

  def log_status_change
    state_histories.new(from_state: aasm.from_state, to_state: aasm.to_state, current_event: aasm.current_event)
  end

  def send_notifications
    new_author_notification
    users.where.not(id: created_by.id).each { |user| new_notification(user) }
  end

  def new_author_notification
    new_notification(created_by)
  end

  def new_notification(user)
    notifications.new(body: "O vídeo #{title} foi movido para #{state_verbose}", user: user)
  end

  def increase_version
    self.version += 1
  end

  def revised_by_custumer!
    self.revised_by_custumer = true
  end

  def description_present?
    description.present?
  end
end
