class AddLearningElements < ActiveRecord::Migration[5.1]
  def change
    add_column :exercise_attempts, :attempt_successful, :boolean
    add_column :chapters, :position_in_course, :integer
    add_column :courses, :position_in_chapter, :integer
    add_column :unit_exercises, :position_in_unit, :integer
    add_column :unit_lessons, :position_in_unit, :integer
    add_column :unit_examples, :position_in_unit, :integer
  end
end
