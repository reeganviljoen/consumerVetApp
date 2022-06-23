class AppointmentsController < ApplicationController
  def new
    header = {
      'Authorization': cookies[:token]
    }
    response = HTTParty.get('http://localhost:3000/user', headers: header)
    @user = response.parsed_response
  end

  def create 
    header = {
      'Authorization': cookies['token']
    }

    vet_response = HTTParty.get('http://localhost:3000/vets', headers: header)

    vet_email = ''
    vet_response.each do |vet|
      vet['pets'].each do |pet|
        pet['registrations'].each do |registration| 
          if registration['id'].to_s == appointment_params[:registration_id]
            vet_email = vet['email']
          end
        end
      end
    end 

    response = HTTParty.post("http://localhost:3000/pets/#{appointment_params[:pet_id]}/appointment" ,
                              body: { vet_email: vet_email, date: appointment_params[:date] }, 
                              headers: header)

    if response.success?
      @user = response.parsed_response
      redirect_to user_path(@user['id'])  
    else 
      render :new, status: :unprocessable_entity
    end
  end

  private
  def appointment_params
    params.permit(:date, :pet_id, :registration_id)
  end
end
