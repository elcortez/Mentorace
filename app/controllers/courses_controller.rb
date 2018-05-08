class CoursesController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def index
  end

  def show
    @course = Course.find(params[:id])
  end
end
