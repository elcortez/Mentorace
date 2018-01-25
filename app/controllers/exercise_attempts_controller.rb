class ExerciseAttemptsController < ApplicationController
  def new
    @exercise_attempt = ExerciseAttempt.new
  end
end
