class Exercise < ApplicationRecord
  include LearningElementConcern

  belongs_to :unit
  has_many :exercises_attempts
  has_one :learning_status
  validate :unique_exercise_position_in_unit
end
