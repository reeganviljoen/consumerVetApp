class AppointmentsController < ApplicationController
  def new
    @user = PetsApi::UsersApi.new(token = cookies[:token]).get_user
  end

  def create 
    response = HTTParty.post("#{@api_url}/pets/#{appointment_params[:pet_id]}/appointment" ,
                              body: { vet_email: vet_email, date: appointment_params[:date] }, 
                              headers: @header)
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

  def vet_email
    response = HTTParty.get("#{@api_url}/vets", headers: @header)
    email = ''
    response.parsed_response.each do |vet|
      vet['pets'].each do |pet|
        pet['registrations'].each do |registration| 
          if registration['id'].to_s == appointment_params[:registration_id]
            email = vet['email']
          end
        end
      end
    end 
    email 
  end
end
