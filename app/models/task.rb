class Task < ApplicationRecord
  belongs_to :video

  acts_as_paranoid
end
