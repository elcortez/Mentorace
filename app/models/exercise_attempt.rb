class ExerciseAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :unit_exercise
end
