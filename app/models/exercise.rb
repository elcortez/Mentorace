class Exercise < ApplicationRecord
  validate :unique_exercise_position_in_lesson

  belongs_to :lesson
  has_many :exercises_attempts
  has_one :learning_status

  has_one :next_exercise_in_lesson, -> (exercise) {
    where(
      position_in_lesson: exercise.position_in_lesson + 1,
      lesson_id: exercise.lesson_id
    ).limit(1)
  }, through: :lesson, source: :exercises

  has_one :previous_exercise_in_lesson, -> (exercise) {
    where(
      position_in_lesson: exercise.position_in_lesson - 1,
      lesson_id: exercise.lesson_id
    ).limit(1)
  }, through: :lesson, source: :exercises

  def unique_exercise_position_in_lesson
    return unless self.lesson.exercises.pluck(:position_in_lesson).include?(self.position_in_lesson)
    errors.add(:position_in_lesson, 'already taken')
  end

  def previous_exercise
    return previous_exercise_in_lesson if previous_exercise_in_lesson

    previous_lesson = self.lesson.previous_lesson_in_chapter
    return previous_lesson.exercises_ordered.last if previous_lesson

    previous_chapter = self.lesson.chapter.previous_chapter_in_course
    return previous_chapter.lessons_ordered.last.exercises_ordered.last if previous_chapter
  end
end
