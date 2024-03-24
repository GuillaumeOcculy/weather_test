class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      
      flash[:success] = "Logged in!"
      redirect_to root_path
    else
      flash[:danger] = "Email or password is invalid"
      render "new", status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil

    flash[:info] = "Logged out!"
    redirect_to root_path
  end
end
