class UsersController < ApplicationController
  def create
    response = vetsApi::UsersApi.new(params: user_params).create_user
    if response.created?
      @user = response.parsed_response
      cookies[:token] = @user['auth_token']
      redirect_to user_path(@user['id'])  
    else 
      flash.now[:alert] = 'User couldnt be created'
      render :new, status: :unprocessable_entity
    end
  end

  def authenticate
    response = VetsApi::UsersApi.new(params: user_params).authenticate
    if response.success?
      @user = response.parsed_response
      cookies[:token] = @user['auth_token']
      redirect_to user_path(@user['id']) 
    else 
      flash.now[:alert] = 'Email or password incorrect'
      render :signin, status: :unauthorized
    end 
  end

  def show
    @user = VetsApi::UsersApi.new(cookies[:token]).get_user
  end

  private
  def user_params
    params.permit(:name, :email, :password, :role)
  end
end
