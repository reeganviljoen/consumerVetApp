require 'rails_helper'

RSpec.describe VetsApi::User do
  let(:url) { 'http://localhost:3000' }
  let(:body) do 
    {
      id: 1,
      email: 'reegan@example.com',
      name: 'reegan',
      auth_token: 'token',
      role: 'owner',
      pets: [
        {
          id: 1,
          name: 'Jinx',
          animal: 'Cat',
          registrations: [
            {
              id: 1,
              user_id: 1,
              pet_id: 1,
              registration_date: '2022-06-30T07:48:21.226Z',
              accepted: false,
              user: "nici",
              vet_registration: true,
              appointments: []
          }
          ]
        }
      ]
    }.to_json
  end

  let(:headers) do 
    {
    'Accept'=>'*/*',
    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'User-Agent'=>'Ruby',
    'Authorization': 'token'
    }
  end

  describe '#create_registration' do
    let(:registration) do
      {
        vet_email: 'nicci@example.com'
      }
    end

    let(:params) do
      {
        vet_email: 'nicci@example.com',
        pet_id: '1'
      }
    end

    it 'invokes the api' do
      stub_request(:post, "#{url}/pets/1/register").
        with(body: registration, headers: headers).
          to_return(status: 200, body: body, headers: {})
      
      response = VetsApi::Registration.new('token', params: params).create_registration

      expect(response.body).to eq(body)
    end
  end

  context '#accept_registration' do
    let(:params) do
      {
        id: '1'
      }
    end
  
    it 'invokes the api' do
      stub_request(:post, "#{url}/registrations/1").
        with(headers: headers).
          to_return(status: 200, body: body, headers: {})

      response = VetsApi::Registration.new('token', params: params).accept_registration

      expect(response.body).to eq(body)
    end
  end
end