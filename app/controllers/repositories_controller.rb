class RepositoriesController < ApplicationController
  include ApiWrapper

  before_action :authenticate_request

  def index
    response = get("https://api.github.com/users/#{username}/repos")
    if response.code == '200'
      render json: response.body, status: :ok
    else
      render json: { error: response.message }, status: response.code
    end
  end

  private

  def username
    @username ||= @current_user.username
  end
end
