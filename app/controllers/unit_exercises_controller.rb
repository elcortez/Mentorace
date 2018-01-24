class UnitExercisesController < ApplicationController
  before_action :authenticate_user!
  def show
    @unit_exercises = UnitExercise.find(params[:id])
  end
end
