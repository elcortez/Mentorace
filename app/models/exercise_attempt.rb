class ExerciseAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :unit_exercise
  before_validation :set_successful

  def set_successful
    self.attempt_successful = self.attempted_answer == self.unit_exercise.answer
  end
end
