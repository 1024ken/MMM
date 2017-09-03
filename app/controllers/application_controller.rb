class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :check_logined

  # private
  # def check_logined
  # end
end
