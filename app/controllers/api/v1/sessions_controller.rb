class Api::V1::SessionsController < ActionController::API
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode({ user_id: user.id })
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Wrong credentials' }, status: :unauthorized
    end
  end
end
