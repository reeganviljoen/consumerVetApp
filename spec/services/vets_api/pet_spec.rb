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
          registrations: []
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

  let(:pet) do
    {
      name: 'Jinx',
      animal: 'cat'
    }.to_json
  end

  describe '#create_pet' do
    it 'invokes the api' do
      stub_request(:post, "#{url}/pets/create").
        with(body: pet, headers: headers).
          to_return(status: 200, body: body, headers: {})
      
      response = VetsApi::Pet.new('token', params: pet).create_pet

      expect(response.body).to eq(body)
    end
  end
end