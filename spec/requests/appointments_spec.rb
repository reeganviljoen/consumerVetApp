require 'rails_helper'

RSpec.describe 'Appointments', type: :request do
  let(:api_response) { instance_double HTTParty::Response}
  let(:user) do 
    {
      'id' => 1, 
      'pets' => 
      [
        {
          'id' => 1,
          'registrations' => 
          [
            {
              'id' => 1,
              'appointments' => 
              [
                {
                  'id' => 1,
                  'date' => '2022-06-06'
                }
              ]
            }
          ]
        }
      ]
    }
  end

  describe 'GET users/:id/appointment' do
    let(:dummy_api) { instance_double 'VetsApi::User' }
    
    before do
      allow(VetsApi::User).to receive(:new).and_return(dummy_api)
      allow(dummy_api).to receive(:get_user).and_return(api_response)
      allow(api_response).to receive(:parsed_response).and_return(user)
      get user_appointments_path(1)
    end

    context 'when the request is valid' do
      it 'it retruns the page succesfully' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /users/:user_id/pets/:id/appointments/new' do
    let(:dummy_api) { instance_double 'VetsApi::User' }
        
    before do
      allow(VetsApi::User).to receive(:new).and_return(dummy_api)
      allow(dummy_api).to receive(:get_user).and_return(api_response)
      allow(api_response).to receive(:parsed_response).and_return(user)
      get new_user_pet_registration_appointment_path(1,1,1)
    end

    context 'when the request is valid' do
      it 'retruns the page succesfully' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /users/:user_id/pets/:pet_id/registrations/:registration_id/appointments' do
    let(:dummy_api) { instance_double 'VetsApi::Appointment' }

    before do
      allow(VetsApi::Appointment).to receive(:new).and_return(dummy_api)
      allow(dummy_api).to receive(:create_appointment).and_return(api_response)
      allow(api_response).to receive(:parsed_response).and_return(user)
      allow(api_response).to receive(:created?).and_return(true)
      post user_pet_registration_appointments_path(1,1,1)
    end

    context 'when the request is valid' do
      it 'redirects the page sucefully' do
        expect(response).to have_http_status(302)
      end
    end
  end
end
