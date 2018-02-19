class AttemptsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :find_objects
  before_action :validate_user_presence

  def new
    @attempt = Attempt.new
  end

  def create
  end

  private

  def validate_user_presence
    unless current_user.can_access_exercise?(@exercise)
      status = LearningStatus.find_by(user_id: current_user.id, course_id: @course.id)

      return redirect_to new_course_chapter_unit_exercise_attempt_path(
        course_id: status.course_id,
        chapter_id: status.chapter_id,
        unit_id: status.unit_id,
        exercise_id: status.exercise_id
      )
    end
  end

  def find_objects
    @exercise = Exercise.find(params[:exercise_id])
    @unit = @exercise.unit
    @chapter = @unit.chapter
    @course = @chapter.course
  end
end
