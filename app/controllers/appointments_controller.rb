class AppointmentsController < ApplicationController
  def new
    header = {
      'Authorization': cookies[:token]
    }
    response = HTTParty.get('http://localhost:3000/user', headers: header)
    @user = JSON.parse(response.to_s)
  end

  private
  def appoitment_params
    params.permit(:date)
  end
end
