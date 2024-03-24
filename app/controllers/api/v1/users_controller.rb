class Api::V1::UsersController < Api::V1::BaseController
  before_action :find_user, only: [:edit, :update]

  def create
    user = User.new(user_params)

    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token }, status: :created
    else
      render json: { error: user.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :prefered_city)
  end
end
