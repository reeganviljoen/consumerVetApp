require 'rails_helper'

RSpec.describe VetsApi::User do
  let(:url) { 'http://localhost:3000' }

  describe '#create_pet' do
    it 'invokes the api' do
      stub_request(:post, "#{url}/pets/create").
        to_return(status: 200, body: '', headers: {})
      
      response = VetsApi::Pet.new('token', params: '').create_pet
    end
  end
end