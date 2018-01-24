class UnitsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def show
    @unit = Unit.find(params[:id])
  end
end
