class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :url
      t.belongs_to :source, polymorphic: true, null: false
      t.belongs_to :created_by, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
