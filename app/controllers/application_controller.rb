class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def require_login
    unless current_user
      flash[:alert] = "You must be logged in to see this person's contact information!"
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
