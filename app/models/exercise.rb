class Exercise < ApplicationRecord
  validate :unique_exercise_position_in_unit

  belongs_to :unit
  has_many :exercises_attempts
  has_one :learning_status

  has_one :next_exercise_in_unit, -> (exercise) {
    where(
      position_in_unit: exercise.position_in_unit + 1,
      unit_id: exercise.unit_id
    ).limit(1)
  }, through: :unit, source: :exercises

  has_one :previous_exercise_in_unit, -> (exercise) {
    where(
      position_in_unit: exercise.position_in_unit - 1,
      unit_id: exercise.unit_id
    ).limit(1)
  }, through: :unit, source: :exercises

  def unique_exercise_position_in_unit
    return unless self.unit.exercises.pluck(:position_in_unit).include?(self.position_in_unit)
    errors.add(:position_in_unit, 'already taken')
  end

  def previous_exercise
    return previous_exercise_in_unit if previous_exercise_in_unit

    previous_unit = self.unit.previous_unit_in_chapter
    return previous_unit.exercises_ordered.last if previous_unit

    previous_chapter = self.unit.chapter.previous_chapter_in_course
    return previous_chapter.units_ordered.last.exercises_ordered.last if previous_chapter
  end
end
