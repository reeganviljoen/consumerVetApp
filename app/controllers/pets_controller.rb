class PetsController < ApplicationController
  
  def index
    header = {
      'Authorization': cookies[:token]
    }
    response = HTTParty.get('http://localhost:3000/user', headers: header)
    @user = JSON.parse(response.to_s)
  end

  def new
    header = {
      'Authorization': cookies[:token]
    }

    user_response = HTTParty.get('http://localhost:3000/user', headers: header)
    @user = JSON.parse(user_response.to_s)
  end

  private
  def pet_params
    params.permit(:name, :animal)
  end
end
