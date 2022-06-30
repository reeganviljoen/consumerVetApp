class PetsController < ApplicationController  
  before_action :set_user, only: [:index, :new]
  
  def create
    response = VetsApi::PetsApi.new(cookies[:token], params: pet_params).create_pet
    if response.created?
      @user = response.parsed_response
      flash[:notice] = 'Created pet'
      redirect_to user_pets_path(@user['id'])  
    else 
      @user = VetsApi::UsersApi.new(cookies[:token]).get_user
      flash.now[:alert] = 'Couldnt create pet'
      render :new, status: :unprocessable_entity
    end
  end

  private
  def pet_params
    params.permit(:name, :animal)
  end

  def set_user
    @user = VetsApi::UsersApi.new(cookies[:token]).get_user
  end
end
