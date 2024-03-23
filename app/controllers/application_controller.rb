class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_user
    redirect_to [:new, :session], notice: "You must be logged in to access this page" unless current_user
  end
end
