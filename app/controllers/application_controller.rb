class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_user
    unless current_user
      flash[:warning] = "You must be logged in to access this page"
      redirect_to [:new, :session], warning: "You must be logged in to access this page"
    end
  end
end
