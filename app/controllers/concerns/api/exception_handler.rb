module Api::ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from JWT::DecodeError do |e|
      render json: { error: 'Invalid token' }, status: :unauthorized
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { error: 'Record not found' }, status: :not_found
    end
  end
end
