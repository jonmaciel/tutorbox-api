class VideoLabel < ApplicationRecord
  has_and_belongs_to_many :videos, inverse_of: :labels
end
