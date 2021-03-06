class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :video

  acts_as_paranoid

  enum comment_destination: [:administrative, :customer]
end
