class CreateUnitExamples < ActiveRecord::Migration[5.1]
  def change
    create_table :unit_examples do |t|
      t.references :unit, foreign_key: true
      t.text :content
      t.integer :position_in_unit

      t.timestamps
    end
  end
end
