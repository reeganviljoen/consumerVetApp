class UsersController < ApplicationController
  def create
    response = HTTParty.post('http://localhost:3000/signup', body:user_params)
    binding.pry
    if response.success?
      redirect_to 
    else 
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :role)
  end
end
