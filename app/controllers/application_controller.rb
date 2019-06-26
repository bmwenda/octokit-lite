class ApplicationController < ActionController::API
  def heartbeat
    render json: { status: :ok }
  end
end
