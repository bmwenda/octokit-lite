class ApplicationController < ActionController::API
  include ::ActionController::Serialization

  def heartbeat
    render json: { status: :ok }
  end
end
