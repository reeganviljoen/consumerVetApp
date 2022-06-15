class UsersController < ApplicationController
  def create
    @response = HTTParty.post('http://localhost:3000/signup', 
      body{
        name: user_params[:user][:name], 
        email: user_params[:user][:email], 
        role: user_params[:user][:role], 
        name: user_params[:user][:password]
      })
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end
end
