class RepositoriesController < ApplicationController
  include ApiWrapper

  before_action :authenticate_request

  def index
    response = get("https://api.github.com/users/#{username}/repos")
    if response.code == '200'
      render json: response.body, status: :ok
    else
      render json: { message: response.message }, status: response.code
    end
  end

  def create
    @repository = Repository.new(repository_params)
    if @repository.save
      GithubRepoGenerator.new(username, @repository.attributes).create_repo
      render json: @repository, status: :ok
    else
      render json: {
        message: { errors: @repository.errors.full_messages }
      }, status: :unprocessable_entity
    end
  end

  def show
    if repository
      render json: @repository, status: :ok
    else
      not_found
    end
  end

  def destroy
    if repository
      repository.destroy
      render json: { message: 'repository deleted' }, status: :no_content
    else
      not_found
    end
  end

  private

  def username
    @username ||= @current_user.username
  end

  def repository
    @repository ||= Repository.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def repository_params
    params.permit(:user_id, :name, :description)
  end
end
