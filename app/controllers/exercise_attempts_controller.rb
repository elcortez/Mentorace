class ExerciseAttemptsController < ApplicationController
  before_action :authenticate_user!

  def new
    @unit_exercise = UnitExercise.find(params[:unit_exercise_id])

    @exercise_attempt = ExerciseAttempt.new(
      unit_exercise_id: @unit_exercise.id,
      user_id: current_user.id
    )
  end
end
