class CreateSystems < ActiveRecord::Migration[5.1]
  def change
    create_table :systems do |t|
      t.string :name, null: false
      t.belongs_to :organization, foreign_key: true, null: false

      t.datetime :deleted_at, index: true
      t.timestamps
    end
  end
end
