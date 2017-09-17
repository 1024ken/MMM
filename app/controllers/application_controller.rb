class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_logined

  # def after_sign_in_path_for(resource)
  #   '/posts'
  # end
  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  PERMISSIBLE_ATTRIBUTES = %i(name avatar avatar_cache)

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: PERMISSIBLE_ATTRIBUTES)
    devise_parameter_sanitizer.permit(:account_update, keys: PERMISSIBLE_ATTRIBUTES)
  end

  private
  def check_logined
  end
end
