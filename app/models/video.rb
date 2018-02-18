class Video < ApplicationRecord
  include AASM

  belongs_to :system
  belongs_to :user
  has_many :comments
  has_many :tasks
  has_many :state_histories
  has_many :attachments, as: :source, inverse_of: :source


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

    event :send_request do
      transitions from: [:draft], to: :script_creation
    end

    event :cancel_request do
      transitions from: [:script_creation], to: :draft
    end

    event :send_to_production do
      transitions from: [:script_creation], to: :production
    end

    event :cancel_production do
      transitions from: [:production], to: :script_creation
    end

    event :send_to_screenwriter_revision do
      transitions from: [:production], to: :screenwriter_revision
    end

    event :send_to_customer_revision do
      transitions from: [:screenwriter_revision], to: :customer_revision
    end

    event :refused_by_customer do
      transitions from: [:customer_revision], to: :screenwriter_revision
    end

    event :approved_by_customer do
      transitions from: [:customer_revision], to: :approved
    end

    def log_status_change
      # TO DO: verify permission
      state_histories << StateHistory.new(
                                        from_state: aasm.aasm.from_state,
                                        to_state: aasm.aasm.to_state,
                                        current_event: aasm.aasm.current_event
                                      )
    end
  end
end
