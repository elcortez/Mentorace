class CreateLearningStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :learning_statuses do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.references :chapter, foreign_key: true
      t.references :lesson, foreign_key: true
      t.references :exercise, foreign_key: true
      t.datetime :finished_at

      t.timestamps
    end
  end
end
