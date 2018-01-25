class ExerciseAttemptsController < ApplicationController
  before_action :authenticate_user!

  def new
    @exercise_attempt = ExerciseAttempt.new(
      user_id: current_user.id,
      unit_exercise_id: @unit_exercise.id
    )
  end
end
