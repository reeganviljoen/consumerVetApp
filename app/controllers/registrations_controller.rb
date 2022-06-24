class RegistrationsController < ApplicationController
  def new
    header = {
      'Authorization': cookies[:token]
    }

    user_response = HTTParty.get('http://localhost:3000/user', headers: header)
    @user = user_response.parsed_response

    vet_response = HTTParty.get('http://localhost:3000/vets', headers: header)
    vets_hash = vet_response.parsed_response
    @vets = []
    vets_hash.each do |vet|
      @vets.push([vet['name'],vet['email']])
    end
  end
  
  def create
    header = {
      'Authorization': cookies['token']
    }
    response = HTTParty.post("http://localhost:3000/pets/#{registration_params[:pet_id]}/register" , body: {vet_email: registration_params[:vet_email]}, headers:header)
    if response.success?
      @user = response.parsed_response
      redirect_to user_pets_path(@user['id'])  
    else 
      render :new, status: :unprocessable_entity, alert: 'Registraion unsucessfull'
    end
  end

  def index 
    header = {
      'Authorization': cookies[:token]
    }

    user_response = HTTParty.get('http://localhost:3000/user', headers: header)
    @user = user_response.parsed_response
  end

  private
  def registration_params
    params.permit(:vet_email, :pet_id)
  end
end
