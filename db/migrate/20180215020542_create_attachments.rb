class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :url
      t.belongs_to :source, polymorphic: true
      t.belongs_to :user, column: :created_by_id, foreign_key: true

      t.timestamps
    end
  end
end
