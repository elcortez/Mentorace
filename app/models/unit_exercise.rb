class UnitExercise < ApplicationRecord
  include LearningElementConcern

  belongs_to :unit
  has_many :exercises_attempts
  validate :unique_exercise_position_in_unit
end
