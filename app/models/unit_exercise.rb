class UnitExercise < ApplicationRecord
  belongs_to :unit
  has_many :exercises_attempts
end
