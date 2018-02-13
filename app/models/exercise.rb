class Exercise < ApplicationRecord
  include LearningElementConcern
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

end
