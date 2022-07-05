require 'rails_helper'

RSpec.describe "Pets", type: :request do
  let(:api_response) { instance_double HTTParty::Response}
  describe "Get /users/:id/pets" do
    let(:dummy_api) { instance_double 'VetsApi::User' }
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
    
    before do 
      allow(VetsApi::User).to receive(:new).and_return(dummy_api)
      allow(dummy_api).to receive(:get_user).and_return(api_response)
      allow(api_response).to receive(:parsed_response).and_return(user)
      get user_pets_path(1)
    end

    context 'when the request is valid' do
      it 'returns the page succesfully' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "Get /users/:id/pets/new" do
    let(:dummy_api) { instance_double 'VetsApi::User' }

    before do 
      allow(VetsApi::User).to receive(:new).and_return(dummy_api)
      allow(dummy_api).to receive(:get_user).and_return(api_response)
      allow(api_response).to receive(:parsed_response).and_return({'id' => 1})
      get new_user_pet_path(1)
    end

    context 'when the request is valid' do
      it 'returns the page succesfully' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST /users/:id/pets" do
    let(:dummy_api) { instance_double 'VetsApi::Pet' }

    before do 
      allow(VetsApi::Pet).to receive(:new).and_return(dummy_api)
      allow(dummy_api).to receive(:create_pet).and_return(api_response)
      allow(api_response).to receive(:created?).and_return(true)
      allow(api_response).to receive(:parsed_response).and_return({'id' => 1})
      post user_pets_path(1)
    end

    context 'when the request is valid' do
      it 'redirects to pets page succesfully' do
        expect(response).to have_http_status(302)
      end
    end
  end
end
