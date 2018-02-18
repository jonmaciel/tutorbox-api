class CreateStateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :state_histories do |t|
      t.belongs_to :video, foreign_key: true
      t.string :from_state
      t.string :to_state
      t.string :current_event

      t.timestamps
    end
  end
end
