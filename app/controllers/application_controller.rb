class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_last_session_url

  def current_user
      User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  private

  def set_last_session_url
    session[:return_to] = session[:next]
    session[:next] = session[:now]
    session[:now] = request.path
  end

end
