class PagesController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
  end

  def about
  end
end
