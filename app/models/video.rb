class Video < ApplicationRecord
  include AASM

  belongs_to :system
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id
  has_many :comments
  has_many :tasks
  has_many :state_histories
  has_many :attachments, as: :source, inverse_of: :source
  has_and_belongs_to_many :users, inverse_of: :videos

  acts_as_paranoid


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
    state :production
    state :screenwriter_revision
    state :customer_revision
    state :approved

    after_all_transitions :log_status_change

    event :cancel_video do
      transitions from: [:draft], to: :canceled
    end

    event :send_request, after: Proc.new { |*_| increase_version } do
      transitions from: [:draft], to: :script_creation, guard: :description_present?
    end

    event :cancel_request do
      transitions from: [:script_creation], to: :draft
    end

    event :send_to_production, :after => Proc.new { |*_| increase_version } do
      transitions from: [:script_creation], to: :production
    end

    event :cancel_production do
      transitions from: [:production], to: :script_creation
    end

    event :send_to_screenwriter_revision, :after => Proc.new { |*_| increase_version } do
      transitions from: [:production], to: :screenwriter_revision
    end

    event :send_to_customer_revision, :after => Proc.new { |*_| increase_version } do
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

  private

  def log_status_change
    state_histories << StateHistory.new(
                                      from_state: aasm.from_state,
                                      to_state: aasm.to_state,
                                      current_event: aasm.current_event
                                    )
  end

  def increase_version
    self.version += 1
  end

  def description_present?
    description.present?
  end
end
