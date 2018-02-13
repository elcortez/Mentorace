class CreateExerciseAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :exercise_attempts do |t|
      t.references :user, foreign_key: true
      t.references :exercise, foreign_key: true
      t.string :attempted_answer
      t.boolean :attempt_successful

      t.timestamps
    end
  end
end
