class UnitsController < ApplicationController
  protect_from_forgery with: :exception

  def show
    @unit = Unit.find(params[:id])
  end
end
