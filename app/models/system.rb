class System < ApplicationRecord
  belongs_to :organization
  has_many :attachments, as: :source, inverse_of: :source

  acts_as_paranoid
end
