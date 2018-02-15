class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.belongs_to :user_role, foreign_key: true
      t.belongs_to :organization, foreign_key: true

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :password_digest
  end
end
