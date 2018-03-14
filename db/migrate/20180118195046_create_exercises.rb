class CreateExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :exercises do |t|
      t.references :lesson, foreign_key: true
      t.text :question_en
      t.string :answer
      t.integer :position_in_lesson

      t.timestamps
    end
  end
end
