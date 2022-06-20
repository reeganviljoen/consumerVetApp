class UsersController < ApplicationController
  def create
    @response = HTTParty.post('http://localhost:3000/signup', body:user_params)
    if @response.success?
      cookies[:user] = {
        id:@response['id'],
        email:@response['email'],
        name:@response['name'],
        pets:@response['pets'].length,
        token:@response['auth_token']
      }.to_json
      @user = JSON.parse(cookies[:user])
      redirect_to user_path(@user['id']) 
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def authenticate
    @response = HTTParty.post('http://localhost:3000/auth/login', body:user_params)
    if @response.success?
      cookies[:user] = {
        id:@response['id'],
        email:@response['email'],
        name:@response['name'],
        pets:@response['pets'].length,
        token:@response['auth_token']
      }.to_json

      @user = JSON.parse(cookies[:user])
      redirect_to user_path(@user['id']) 
    else 
      render :signin, status: :unauthorized
    end 
  end

  def show
    @user = JSON.parse(cookies[:user])
  end

  private
  def user_params
    params.permit(:name, :email, :password, :role)
  end
end
