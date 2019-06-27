class ApplicationController < ActionController::API
  include ::ActionController::Serialization

  def heartbeat
    render json: { status: :ok }
  end

  def not_found
    render json: { message: 'not found' }, status: :not_found
  end

  def unauthorized
    render json: { message: 'Invalid credentials' }, status: :unauthorized
  end

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded_token = JwtHandler.decode(token)
    if decoded_token.key?(:user_id)
      find_user(decoded_token)
    else
      unauthorized
    end
  end

  private

  def find_user(decoded_token)
    @current_user ||= User.find(decoded_token[:user_id])
  rescue ActiveRecord::RecordNotFound
    not_found
  end
end
