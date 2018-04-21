class VideoNotification < ApplicationRecord
  belongs_to :user, inverse_of: :video_notifications
  belongs_to :video, inverse_of: :notifications

  scope :unread, -> { where(read: false) }
end
