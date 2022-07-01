require 'rails_helper'

RSpec.describe VetsApi::User do
  let(:url) { 'http://localhost:3000' }

  describe '#create_registration' do
    let(:params) { { pet_id: '1' } }

    it 'invokes the api' do
      stub_request(:post, "#{url}/pets/1/register").
        to_return(status: 200, body: '', headers: {})
      
      response = VetsApi::Registration.new('token', params: params).create_registration
    end
  end

  context '#accept_registration' do
    let(:params){ { id: '1' } }
  
    it 'invokes the api' do
      stub_request(:post, "#{url}/registrations/1").
        to_return(status: 200, body: '', headers: {})

      response = VetsApi::Registration.new('token', params: params).accept_registration
    end
  end
end