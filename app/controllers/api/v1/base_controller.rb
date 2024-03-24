class Api::V1::BaseController < ActionController::API
  include ::Api::ExceptionHandler

  private

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      begin
        payload = JsonWebToken.decode(token)
        @current_user = User.find(payload[:user_id])
      end
    else
      render json: { error: 'Authorization token not provided' }, status: :unauthorized
    end
  end
end
