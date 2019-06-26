class ApplicationController < ActionController::API
  include ::ActionController::Serialization

  def heartbeat
    render json: { status: :ok }
  end

  def not_found
    render json: { error: 'not found' }, status: :not_found
  end
end
