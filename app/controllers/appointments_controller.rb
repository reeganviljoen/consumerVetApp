class AppointmentsController < ApplicationController
  def new
    @user = VetsApi::UsersApi.new(cookies[:token]).get_user
  end

  def create 
    response = VetsApi::AppoinntmentsApi.new(cookies[:token], params:appointment_params).create_appointment
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

  private
  def appointment_params
    params.permit(:date, :pet_id, :registration_id)
  end
end
