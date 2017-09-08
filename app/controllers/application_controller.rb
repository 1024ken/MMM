class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_logined

  # def after_sign_in_path_for(resource)
  #   '/posts'
  # end

  private
  def check_logined
  end
end
