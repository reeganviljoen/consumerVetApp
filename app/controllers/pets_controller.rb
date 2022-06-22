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

  def create
    header = {
      'Authorization': cookies['token']
    }
    response = HTTParty.post("http://localhost:3000/pets/create" , body: pet_params, headers:header)
    if response.success?
      @user = JSON.parse(response.to_s)
      redirect_to user_path(@user['id'])  
    else 
      render :new, status: :unprocessable_entity, alert: 'Registraion unsucessfull'
    end
  end

  private
  def pet_params
    params.permit(:name, :animal)
  end
end
