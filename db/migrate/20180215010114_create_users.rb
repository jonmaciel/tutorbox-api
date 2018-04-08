class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.belongs_to :organization, foreign_key: true
      t.belongs_to :system, foreign_key: true

      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false
      t.integer :user_role, null: false
      t.string :cellphone
      t.string :facebook_url
      t.json :system_role_params


      t.datetime :deleted_at, index: true
      t.timestamps
    end

    add_index :users, :email
    add_index :users, :password_digest
  end
end
