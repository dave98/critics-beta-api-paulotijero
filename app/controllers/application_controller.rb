class ApplicationController < ActionController::Base
  before_action :authenticate_user, except: %i[index show]

  helper_method %i[current_user logged_in?]

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def log_in(user)
    session[:user_id] = user.id # Crea una cookie en el browser del usuario
    flash[:info] = "You are now logged in"
  end

  def logout
    session.delete(:user_id)
    flash[:info] = "Thanks for using Critics Beta!"
  end

  def authenticate_user
    return if logged_in?

    flash[:message] = "You need to be logged in to perform this action"
    redirect_to login_path
  end
end
