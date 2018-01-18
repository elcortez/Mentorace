class CreateUnitExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :unit_exercises do |t|
      t.references :unit, foreign_key: true
      t.text :question
      t.string :answer

      t.timestamps
    end
  end
end
