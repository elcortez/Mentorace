class CreateAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :attempts do |t|
      t.references :user, foreign_key: true
      t.references :exercise, foreign_key: true
      t.string :attempted_answer
      t.boolean :attempt_successful
      t.integer :experience_to_gain, default: 1

      t.timestamps
    end
  end
end
