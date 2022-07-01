require 'rails_helper'

RSpec.describe VetsApi::Appointment do
  let(:url) { 'http://localhost:3000' }

  describe '#create_appointment' do
    let(:params) do {
      pet_id: 1
      }
    end
    it 'invokes the api' do
      stub_request(:post, "#{url}/pets/#{params[:pet_id]}/appointment").
        to_return(status: 200, body: '', headers: {})
      
      stub_request(:get , "#{url}/vets").
        to_return(status: 200, body:'', headers:{})
      
      response = VetsApi::Appointment.new('token', params: params).create_appointment
    end
  end
end