class UsersController < ApplicationController
  def create
    @response = HTTParty.post('http://localhost:3000/signup', body:user_params)
    if @response.success?
      redirect_to "/users/#{@response['id']}/show"
      cookies[:token] = @response['auth_token']
      cookies[:user] = @response
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def authenticate
    @response = HTTParty.post('http://localhost:3000/auth/login', body:user_params)
    if @response.success?
      redirect_to "/users/#{@response['id']}/show"
      cookies[:token] = @response['auth_token']
      cookies[:user] = @response
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
