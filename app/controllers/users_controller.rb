class UsersController < ApplicationController
  def create
    @response = HTTParty.post('http://localhost:3000/signup', body:user_params)
    if @response.success?
      @user = JSON.parse(response.to_s)
      cookies[:token] = @user['auth_token']
      redirect_to user_path(@user['id'])  
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def authenticate
    response = HTTParty.post('http://localhost:3000/auth/login', body:user_params)
    if response.success?
      @user = JSON.parse(response.to_s)
      cookies[:token] = @user['auth_token']
      redirect_to user_path(@user['id']) 
    else 
      render :signin, status: :unauthorized
    end 
  end

  def show
    header = {
      'Authorization': cookies[:token]
    }
    response = HTTParty.get('http://localhost:3000/user', headers: header)
    @user = JSON.parse(response.to_s)
  end

  private
  def user_params
    params.permit(:name, :email, :password, :role)
  end
end
