class UsersController < ApplicationController
  before_action :authenticate_request, except: :create

  def create
    @user = User.new(user_params)
    if @user.save
      token = AuthenticateUser.new(@user.username, @user.password).generate_token
      render json: { token: token }, status: :created
    else
      render json: {
        message: { errors: @user.errors.full_messages }
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
