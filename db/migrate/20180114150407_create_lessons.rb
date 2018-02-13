class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.references :unit, foreign_key: true
      t.text :content
      t.integer :position_in_unit

      t.timestamps
    end
  end
end
