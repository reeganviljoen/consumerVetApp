class RegistrationsController < ApplicationController

  def new 
    @user = PetsApi::UsersApi.new(token = cookies[:token]).get_user

    vet_response = HTTParty.get("#{@api_url}/vets", headers: @header)
    vets_hash = vet_response.parsed_response
    @vets = []
    vets_hash.each do |vet|
      @vets.push([vet['name'],vet['email']])
    end
  end
  
  def create
    response = HTTParty.post("#{@api_url}/pets/#{registration_params[:pet_id]}/register" , 
          body: {vet_email: registration_params[:vet_email]}, headers: @header)
    if response.created?
      @user = response.parsed_response
      redirect_to user_pets_path(@user['id'])  
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def index 
    @user = PetsApi::UsersApi.new(token = cookies[:token]).get_user
  end

  def update
    response = HTTParty.post("#{@api_url}/registrations/#{registration_params[:id]}", headers: @header)
    if response.success?
      @user = response.parsed_response
      flash[:notice] = 'Accepted registration'
      redirect_to user_registrations_path(@user['id'])  
    else  
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def registration_params
    params.permit(:vet_email, :pet_id, :id)
  end
end
