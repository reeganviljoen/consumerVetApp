require 'rails_helper'

RSpec.describe "Pets", type: :request do
  describe "Get /users/:id/pets" do
    let(:dummy_api) { instance_double 'VetsApi::User' }
    let(:api_response) { instance_double HTTParty::Response, body: {id: 1}.to_json}
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
      get '/users/1/pets'
    end

    context 'when the request is valid' do
      it 'returns the page succesfully' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "Get /users/:id/pets/new" do
    let(:dummy_api) { instance_double 'VetsApi::User' }
    let(:api_response) { instance_double HTTParty::Response, body: {id: 1}.to_json}

    before do 
      allow(VetsApi::User).to receive(:new).and_return(dummy_api)
      allow(dummy_api).to receive(:get_user).and_return(api_response)
      allow(api_response).to receive(:parsed_response).and_return({'id' => 1})
      get '/users/1/pets/new'
    end

    context 'when the request is valid' do
      it 'returns the page succesfully' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST /users/:id/pets" do
    let(:dummy_api) { instance_double 'VetsApi::Pet' }
    let(:api_response) { instance_double HTTParty::Response, body: {id: 1}.to_json, code: 302}

    before do 
      allow(VetsApi::Pet).to receive(:new).and_return(dummy_api)
      allow(dummy_api).to receive(:create_pet).and_return(api_response)
      allow(api_response).to receive(:created?).and_return(true)
      allow(api_response).to receive(:parsed_response).and_return({'id' => 1})
      post '/users/1/pets'
    end

    context 'when the signup is valid' do
      it 'redirects to pets page succesfully' do
        expect(response).to have_http_status(302)
      end
    end
  end
end
