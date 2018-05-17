class CreateExercises < ActiveRecord::Migration[5.1]
  def change
    create_table :exercises do |t|
      t.references :lesson, foreign_key: true
      t.text :question_en
      t.string :answer
      t.string :hint
      t.integer :position_in_lesson
      t.integer :experience_given, default: 1

      t.timestamps
    end
  end
end
