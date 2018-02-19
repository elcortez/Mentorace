class AttemptsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_objects

  def new
    if current_user.can_access_exercise?(@exercise)
      @attempt = Attempt.new
    else
      status = LearningStatus.find_by(user_id: current_user.id, course_id: @course.id)

      redirect_to new_course_chapter_unit_exercise_attempt_path(
        course_id: status.course_id,
        chapter_id: status.chapter_id,
        unit_id: status.unit_id,
        exercise_id: status.exercise_id
      )
    end
  end

  def create
    fallback_params = {
      course_id: @unit.chapter.course_id,
      chapter_id: @unit.chapter_id,
      unit_id: @unit.id,
      exercise_id: @unit.exercises.first.id
    }

    redirect_back fallback_location: new_course_chapter_unit_exercise_attempt_path(fallback_params)
  end

  private

  def find_objects
    @exercise = Exercise.find(params[:exercise_id])
    @unit = @exercise.unit
    @chapter = @unit.chapter
    @course = @chapter.course
  end
end
