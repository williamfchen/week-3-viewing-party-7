class ApplicationController < ActionController::Base
  before_action :require_login, only: [:dashboard]
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in or registered to create a movie party"
      redirect_back(fallback_location: root_path)
    end
  end
end
