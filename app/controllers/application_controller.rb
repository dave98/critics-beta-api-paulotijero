class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: %i[index show]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index; end

  def show; end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)  # request.referer -> Lo redirecciono al lugar de donde viene || sino al root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username birth_date])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end
end
