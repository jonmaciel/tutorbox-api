class CreateJoinTableVideoUsers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :videos, :users do |t|
      t.references :video, foreign_key: true
      t.references :user, foreign_key: true
      t.index [:video_id, :user_id]
      t.index [:user_id, :video_id]
    end
  end
end
