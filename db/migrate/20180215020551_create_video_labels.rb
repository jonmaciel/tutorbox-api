class CreateVideoLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :video_labels do |t|
      t.string :title

      t.timestamps
    end
  end
end
