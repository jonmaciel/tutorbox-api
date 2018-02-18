class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :video, foreign_key: true
      t.belongs_to :author,  foreign_key: { to_table: :users }
      t.string :body

      t.timestamps
    end
  end
end
