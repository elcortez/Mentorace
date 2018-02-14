class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  before_validation :set_successful
  after_create :update_learning_status

  def set_successful
    self.attempt_successful = self.attempted_answer.present? && self.attempted_answer == self.exercise.answer
  end

  def update_learning_status
    return unless self.attempt_successful
    exercise = self.exercise

    learning_status = self.user.learning_statuses.find_by(
      exercise_id: exercise.id,
      user_id: self.user_id
    )

    return unless learning_status

    if exercise.next_exercise_in_unit
      learning_status.exercise_id = exercise.next_exercise_in_unit.id

    elsif next_unit = exercise.unit.next_unit_in_chapter
      learning_status.unit_id = next_unit.id
      learning_status.exercise_id = next_unit.exercises_ordered.first.id

    elsif next_chapter = exercise.unit.chapter.next_chapter_in_course
      learning_status.chapter_id = next_chapter.id

      unit = next_chapter.units_ordered.first
      learning_status.unit_id = unit.id
      learning_status.exercise_id = unit.exercises_ordered.first.id

    else
      return :finished
    end

    learning_status.save
  end
end
