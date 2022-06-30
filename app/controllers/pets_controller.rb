class PetsController < ApplicationController  
  def index
    @user = VetsApi::UsersApi.new(token = cookies[:token]).get_user
  end

  def new
    @user = VetsApi::UsersApi.new(token = cookies[:token]).get_user
  end

  def create
    response = HTTParty.post("#{@api_url}/pets/create" , body: pet_params, headers: @header)
    if response.created?
      @user = response.parsed_response
      flash[:notice] = 'Created pet'
      redirect_to user_pets_path(@user['id'])  
    else 
      response = HTTParty.get("#{@api_url}/user", headers: @header)
      @user = response.parsed_response
      flash.now[:alert] = 'Couldnt create pet'
      render :new, status: :unprocessable_entity
    end
  end

  private
  def pet_params
    params.permit(:name, :animal)
  end
end
