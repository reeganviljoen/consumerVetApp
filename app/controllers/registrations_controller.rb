class RegistrationsController < ApplicationController
  def new
    header = {
      'Authorization': cookies[:token]
    }

    user_response = HTTParty.get('http://localhost:3000/user', headers: header)
    @user = JSON.parse(user_response.to_s)

    vet_response = HTTParty.get('http://localhost:3000/vets', headers: header)
    vets_hash = JSON.parse(vet_response.to_s)
    @vets = []
    vets_hash.each do |vet|
      @vets.push([vet['name'],vet['email']])
    end
  end
  
  def create
    header = {
      'Authorization': JSON.parse(cookies[:user])['token']
    }
    response = HTTParty.post("http://localhost:3000/pets#{registration_params[:id]}/register", 
                              body:{vet_email: registration_params[:vet_email]})
    if @response.success?

      @user = JSON.parse(cookies[:user])
      redirect_to user_path(@user['id']) 
    else 
      render :new, status: :unprocessable_entity
    end
  end

  private
  def registration_params
    params.permit(:vet_email, :id)
  end
end
