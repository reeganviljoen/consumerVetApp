class PetsController < ApplicationController
  
  def index
    header = {
      'Authorization': cookies[:token]
    }
    response = HTTParty.get('http://localhost:3000/user', headers: header)
    @user = response.parsed_response

  end

  def new
    header = {
      'Authorization': cookies[:token]
    }

    response = HTTParty.get('http://localhost:3000/user', headers: header)
    @user = response.parsed_response
  end

  def create
    header = {
      'Authorization': cookies['token']
    }
    response = HTTParty.post("http://localhost:3000/pets/create" , body: pet_params, headers:header)
    if response.success?
      @user = response.parsed_response
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
