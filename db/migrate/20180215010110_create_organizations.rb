class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
