class AppointmentsController < ApplicationController
  before_action :set_user, only: [:new, :index]

  def create 
    response = VetsApi::AppoinntmentsApi.new(cookies[:token], params:appointment_params).create_appointment
    if response.created?
      @user = response.parsed_response
      redirect_to user_pets_path(@user['id'])  
    else 
      @user = VetsApi::UsersApi.new(cookies[:token]).get_user
      flash.now[:alert] = 'Couldnt create Appointment'
      render :new, status: :unprocessable_entity
    end
  end

  private
  def appointment_params
    params.permit(:date, :pet_id, :registration_id)
  end

  def set_user
    @user = VetsApi::UsersApi.new(token = cookies[:token]).get_user 
  end
end
