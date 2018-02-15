class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :description
      t.string :url
      t.string :aasm_state
      t.json :labels
      t.belongs_to :system, foreign_key: true
      t.belongs_to :user, column: :created_by_id, foreign_key: true

      t.timestamps
    end
  end
end
