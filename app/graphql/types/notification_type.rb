Types::NotificationType = GraphQL::ObjectType.define do
  name 'Notification'

  field :id, types.ID
  field :notificationsUnreadCount, types.Int, 'Get notifications' do
    resolve ->(_, _, context) { context[:current_user].video_notifications.unread.count }
  end

  field :videoNotifications, types[Types::VideoNotificationType], 'Get notifications' do
    resolve ->(_, _, context) { context[:current_user].video_notifications.order(id: :desc) }
  end
end
