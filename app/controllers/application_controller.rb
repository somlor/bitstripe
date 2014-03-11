class ApplicationController < ActionController::Base
  include SessionsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def redirect_logged_in_user
    if logged_in?
      redirect_to root_url
    end
  end

  def redirect_unless_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
