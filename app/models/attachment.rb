class Attachment < ApplicationRecord
  belongs_to :source, polymorphic: true
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id

  acts_as_paranoid

  def name
    return url.split('/').last if self[:name].blank?
    self[:name]
  end
end
