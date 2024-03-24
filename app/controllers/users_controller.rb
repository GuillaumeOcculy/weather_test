class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User created successfully"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:notice] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User updated successfully"
      redirect_to edit_user_path(@user)
    else
      flash[:notice] = @user.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :prefered_city)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
