class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :img_url
      t.integer :unit_id
      t.integer :position_in_unit

      t.timestamps
    end
  end
end
