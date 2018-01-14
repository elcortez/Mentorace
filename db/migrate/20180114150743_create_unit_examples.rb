class CreateUnitExamples < ActiveRecord::Migration[5.1]
  def change
    create_table :unit_examples do |t|
      t.references :unit, foreign_key: true
      t.text :content
      t.integer :unit_position

      t.timestamps
    end
  end
end