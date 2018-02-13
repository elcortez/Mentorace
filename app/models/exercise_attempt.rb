class ExerciseAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  before_validation :set_successful
  after_create :update_learning_status, if: -> (e) { e.attempt_successful? }

  def set_successful
    self.attempt_successful = self.attempted_answer.present? && self.attempted_answer == self.exercise.answer
  end

  def update_learning_status    
  end
end
