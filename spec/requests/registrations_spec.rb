require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'Get /users/:id/registrations' do
    let(:dummy_api) { instance_double 'VetsApi::User' }
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
                  {'id' => 1}
                ]
              }
            ]
          }
        ]
      }
    end
    
    before do 
      allow(VetsApi::User).to receive(:new).and_return(dummy_api)
      allow(dummy_api).to receive(:get_user).and_return(api_response)
      allow(api_response).to receive(:parsed_response).and_return(user)
      get '/users/1/registrations'
    end

    context 'when the request is valid' do
      it 'returns the page succesfully' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'Get /users/:id/pets/:id/registrations/new' do
    let(:dummy_api) { instance_double 'VetsApi::User' }
    let(:user_response) { instance_double HTTParty::Response}
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
                  {'id' => 1}
                ]
              }
            ]
          }
        ]
      }
    end

    let(:vets_response) { instance_double HTTParty::Response}
    let(:vets) { [ {'id' => 1, 'name' => 'reegan', 'email' => 'foo@bar.com'} ] }
    
    before do 
      allow(VetsApi::User).to receive(:new).and_return(dummy_api)

      allow(dummy_api).to receive(:get_vets).and_return(vets_response)
      allow(vets_response).to receive(:parsed_response).and_return(vets)

      allow(dummy_api).to receive(:get_user).and_return(user_response)
      allow(user_response).to receive(:parsed_response).and_return(user)

      get '/users/1/pets/1/registrations/new'
    end

    context 'when the request is valid' do
      it 'returns the page succesfully' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'Post /users/:id/pets/:id/registrations' do
    let(:dummy_api) { instance_double 'VetsApi::Registration' }
    let(:api_response) { instance_double HTTParty::Response}

    before do
      allow(VetsApi::Registration).to receive(:new).and_return(dummy_api)
      allow(dummy_api).to receive(:create_registration).and_return(api_response)
      allow(api_response).to receive(:parsed_response).and_return({'id' => 1})
      allow(api_response).to receive(:created?).and_return(TRUE)
      post user_pet_registrations_path(1,1)
    end

    context 'when the request is valid' do
      it 'redirects properly' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'Patch /users/:id/registrations/:id' do
    describe 'Post /users/:id/pets/:id/registrations' do
      let(:dummy_api) { instance_double 'VetsApi::Registration' }
      let(:api_response) { instance_double HTTParty::Response}
  
      before do
        allow(VetsApi::Registration).to receive(:new).and_return(dummy_api)
        allow(dummy_api).to receive(:accept_registration).and_return(api_response)
        allow(api_response).to receive(:parsed_response).and_return({'id' => 1})
        allow(api_response).to receive(:success?).and_return(true)
        patch user_registration_path(1,1)
      end

      context 'when the request is valid' do
        it 'redirects properly' do
          expect(response).to have_http_status(302)
        end
      end
    end
  end
end
