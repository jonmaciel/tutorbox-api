class Task < ApplicationRecord
  belongs_to :video
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id

  acts_as_paranoid
end
