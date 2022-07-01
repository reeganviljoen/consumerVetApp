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
      pets: []
  }.to_json
  end

  let(:headers) do 
    {
    'Accept'=>'*/*',
    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'User-Agent'=>'Ruby'
    }
  end


  describe '#create_user' do
    it 'it invokes the api' do
      stub_request(:post, "#{url}/signup").
        with(body: "name=reegan&email=reegan%40example.com&password=password&role=owner").
        to_return(status: 200, body: body, headers: {})

      response = VetsApi::User.new(params: user).create_user
      expect(response.body).to eq(body)
    end
  end
end
