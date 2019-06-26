class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: {
        errors: @user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def show
    if user
      render json: user
    else
      not_found
    end
  end

  private

  def user
    @user ||= User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def user_params
    params.permit(
      :name,
      :username,
      :email,
      :password
    )
  end
end
