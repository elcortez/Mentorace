class ExerciseAttemptsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_unit_exercise

  def new
    @exercise_attempt = ExerciseAttempt.new
  end

  def create
    fallback_params = {
      course_id: @unit.chapter.course_id,
      chapter_id: @unit.chapter_id,
      unit_id: @unit.id,
      unit_exercise_id: @unit.unit_exercises.first.id
    }

    redirect_back fallback_location: new_course_chapter_unit_unit_exercise_exercise_attempt_path(fallback_params)
  end

  private

  def find_unit_exercise
    @unit_exercise = UnitExercise.find(params[:unit_exercise_id])
    @unit = @unit_exercise.unit
  end
end
