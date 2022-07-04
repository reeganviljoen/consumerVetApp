require 'rails_helper'

RSpec.describe "Pets", type: :request do
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
