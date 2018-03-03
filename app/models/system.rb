class System < ApplicationRecord
  belongs_to :organization
  has_many :attachments, as: :source, inverse_of: :source
  has_many :videos, as: :source, inverse_of: :system

  acts_as_paranoid
end
