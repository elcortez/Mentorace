class LessonsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def show
    @lesson = Lesson.find(params[:id])
  end
end
