class Video < ApplicationRecord
  include AASM

  belongs_to :system
  belongs_to :user
  has_many :comments
  has_many :tasks
  has_many :attachments, as: :source, inverse_of: :source
end
