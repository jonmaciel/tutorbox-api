class Attachment < ApplicationRecord
  belongs_to :source, polymorphic: true
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id
end
