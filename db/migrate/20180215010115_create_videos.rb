class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :title, null: false
      t.text :description
      t.text :script
      t.integer :version, default: 0
      t.string :url
      t.integer :upload_type
      t.string :aasm_state
      t.json :labels
      t.boolean :revised_by_custumer, default: false
      t.belongs_to :system, foreign_key: true, null: false
      t.belongs_to :created_by, foreign_key: { to_table: :users }, null: false

      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end
