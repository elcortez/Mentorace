class CreateExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :exercises do |t|
      t.references :unit, foreign_key: true
      t.text :question
      t.string :answer
      t.integer :position_in_unit

      t.timestamps
    end
  end
end
