class ExerciseAttemptsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_exercise

  def new
    @exercise_attempt = ExerciseAttempt.new
  end

  def create
    fallback_params = {
      course_id: @unit.chapter.course_id,
      chapter_id: @unit.chapter_id,
      unit_id: @unit.id,
      exercise_id: @unit.exercises.first.id
    }

    redirect_back fallback_location: new_course_chapter_unit_exercise_exercise_attempt_path(fallback_params)
  end

  private

  def find_exercise
    @exercise = Exercise.find(params[:exercise_id])
    @unit = @exercise.unit
  end
end
