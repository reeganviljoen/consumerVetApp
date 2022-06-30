class RegistrationsController < ApplicationController

  def new 
    @user = VetsApi::UsersApi.new(cookies[:token]).get_user

    vets_response = VetsApi::UsersApi.new(cookies[:token]).get_vets
    @vets = []
    vets_response.each do |vet|
      @vets.push([vet['name'],vet['email']])
    end
  end
  
  def create
    response = VetsApi::RegistrationsApi.new(cookies[:token], params: registration_params ).create_registration
    if response.created?
      @user = response.parsed_response
      redirect_to user_pets_path(@user['id'])  
    else 
      @user = VetsApi::UsersApi.new(cookies[:token]).get_user
      flash.now[:alert] = 'Couldnt create registration'
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
