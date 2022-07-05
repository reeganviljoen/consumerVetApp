require 'rails_helper'

RSpec.describe "Users", type: :request do

  let(:dummy_api) { instance_double 'VetsApi::User' }
  let(:api_response) { instance_double HTTParty::Response}

  describe "POST /users" do
    before do 
      allow(VetsApi::User).to receive(:new).and_return(dummy_api)
      allow(dummy_api).to receive(:create_user).and_return(api_response)
      allow(api_response).to receive(:created?).and_return(true)
      allow(api_response).to receive(:parsed_response).and_return({'id' => 1})
      post '/users'
    end

    context 'when the signup is valid' do
      it 'redirects to users page succesfully' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'Post /login' do
    before do
      allow(VetsApi::User).to receive(:new).and_return(dummy_api)
      allow(dummy_api).to receive(:authenticate).and_return(api_response)
      allow(api_response).to receive(:success?).and_return(true)
      allow(api_response).to receive(:parsed_response).and_return({'id' => 1})
      post '/signin'
    end

    context 'when the login is valid' do
      it 'redirectss to the user page sucecsfully' do
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'Get /users/:id' do
    before do
      allow(VetsApi::User).to receive(:new).and_return(dummy_api)
      allow(dummy_api).to receive(:get_user).and_return(api_response)
      allow(api_response).to receive(:parsed_response).and_return({'id' => 1})
      get '/users/1'
    end

    context 'when the request is valid' do
      it 'returns a ststus 200'  do
        expect(response).to have_http_status(200)
      end
    end
  end
end
