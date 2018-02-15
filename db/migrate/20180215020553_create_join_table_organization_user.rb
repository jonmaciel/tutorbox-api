class CreateJoinTableOrganizationUser < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :organizations do |t|
      t.references :user, foreign_key: true
      t.references :organization, foreign_key: true
      t.index [:user_id, :organization_id]
      t.index [:organization_id, :user_id]
    end
  end
end
