class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :video, foreign_key: true, null: false
      t.belongs_to :author, foreign_key: { to_table: :users }, null: false
      t.integer :comment_destination, null: false
      t.string :body

      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end
