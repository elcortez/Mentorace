class CreateLearningStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :learning_statuses do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.references :chapter, foreign_key: true
      t.references :unit, foreign_key: true
      t.references :unit_exercise, foreign_key: true

      t.timestamps
    end
  end
end
