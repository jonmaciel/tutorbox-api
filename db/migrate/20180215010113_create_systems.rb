class CreateSystems < ActiveRecord::Migration[5.1]
  def change
    create_table :systems do |t|
      t.belongs_to :organization, foreign_key: true

      t.timestamps
    end
  end
end
