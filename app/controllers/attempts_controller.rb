class AttemptsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :find_objects
  before_action :validate_user_presence

  def new
    @attempt = Attempt.new
  end

  def create
    Attempt.create({ user_id: current_user.id }.merge(lesson_params))

    redirect_to_current_learning_status
  end

  private

  def validate_user_presence
    redirect_to_current_learning_status unless current_user.can_access_exercise?(@exercise)
  end

  def redirect_to_current_learning_status
    status = LearningStatus.find_by(user_id: current_user.id, course_id: @course.id)

    return redirect_to new_course_chapter_lesson_exercise_attempt_path(
      course_id: status.course_id,
      chapter_id: status.chapter_id,
      lesson_id: status.lesson_id,
      exercise_id: status.exercise_id
    )
  end

  private

  def lesson_params
    params.require(:attempt).permit(:attempted_answer, :exercise_id)
  end

  def find_objects
    @exercise = Exercise.find(params[:exercise_id])
    @lesson = @exercise.lesson
    @chapter = @lesson.chapter
    @course = @chapter.course
  end
end
