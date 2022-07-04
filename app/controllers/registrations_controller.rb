class RegistrationsController < ApplicationController
  before_action :set_user, only: [:index, :new]

  def new 
    vets_response = VetsApi::User.new(cookies[:token]).get_vets
    @vets = []
    vets_response.each do |vet|
      @vets.push([vet['name'],vet['email']])
    end
  end
  
  def create
    response = VetsApi::Registration.new(cookies[:token], params: registration_params ).create_registration
    if response.created?
      @user = response.parsed_response
      redirect_to user_pets_path(@user['id'])  
    else 
      @user = VetsApi::User.new(cookies[:token]).get_user
      flash.now[:alert] = 'Couldnt create registration'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    response = VetsApi::Registration.new(cookies[:token], params: registration_params).accept_registration
    if response.success?
      @user = response.parsed_response
      flash[:notice] = 'Accepted registration'
      redirect_to user_registrations_path(@user['id'])  
    else  
      @user = VetsApi::User.new(cookies[:token]).get_user
      flash.now[:alert] = 'Couldnt accept registration'
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def registration_params
    params.permit(:vet_email, :pet_id, :id)
  end

  def set_user
    response = VetsApi::User.new(cookies[:token]).get_user
    @user = response.parsed_response
  end
end
