class PagesController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
    return redirect_to user_path(current_user) if user_signed_in?
  end

  def about
  end
end
