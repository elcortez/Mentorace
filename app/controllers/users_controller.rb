class UsersController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :authorize_user

  def show
  end

  def authorize_user
    return redirect_to root_path if current_user.id != params['id'].to_i
  end
end
