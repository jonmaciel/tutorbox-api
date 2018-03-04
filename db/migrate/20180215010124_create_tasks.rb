class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.boolean :done, default: false, null: false

      t.belongs_to :video, foreign_key: true, null: false
      t.belongs_to :created_by, foreign_key: { to_table: :users }, null: false

      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end
