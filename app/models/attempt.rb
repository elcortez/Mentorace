class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  before_validation :set_successful
  after_create :update_learning_status

  def set_successful
    return false unless self.attempted_answer.present?
    return false unless self.attempted_answer.gsub(/ /, '') == self.exercise.answer.gsub(/ /, '')
    self.attempt_successful = true
  end

  def update_learning_status
    return unless self.attempt_successful
    exercise = self.exercise

    learning_status = self.user.learning_statuses.find_by(
      exercise_id: exercise.id,
      user_id: self.user_id
    )

    return unless learning_status

    if exercise.next_exercise_in_lesson
      learning_status.exercise_id = exercise.next_exercise_in_lesson.id

    elsif next_lesson = exercise.lesson.next_lesson_in_chapter
      learning_status.lesson_id = next_lesson.id
      learning_status.exercise_id = next_lesson.exercises_ordered.first.id

    elsif next_chapter = exercise.lesson.chapter.next_chapter_in_course
      learning_status.chapter_id = next_chapter.id

      lesson = next_chapter.lessons_ordered.first
      learning_status.lesson_id = lesson.id
      learning_status.exercise_id = lesson.exercises_ordered.first.id

    else
      learning_status.finished_at = Time.now
    end

    learning_status.save
  end
end
