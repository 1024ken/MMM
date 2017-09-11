class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_logined

  # def after_sign_in_path_for(resource)
  #   '/posts'
  # end
  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  private
  def check_logined
  end
end
