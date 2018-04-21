class CreateVideoNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :video_notifications do |t|
      t.belongs_to :video
      t.belongs_to :user
      t.string :body
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
