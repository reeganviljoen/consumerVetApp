require 'rails_helper'

RSpec.describe VetsApi::User do
  let(:url) { 'http://localhost:3000' }

  describe '#create_user' do
    it 'it invokes the api' do
      stub_request(:post, "#{url}/signup").
          to_return(status: 200, body: '', headers: {})

      response = VetsApi::User.new(params: '').create_user
    end
  end

  describe '#authenticate' do
    it 'invokes the api' do  
      stub_request(:post, "#{url}/auth/login").
        to_return(status: 200, body: '', headers: {})
  
      response = VetsApi::User.new(params: '').authenticate
    end
  end
end
