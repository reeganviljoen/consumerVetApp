require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:test_api) { instance_double 'VetsApi::UsersApi'}
  let(:user) do 
    {
        name: 'foo',
        email: 'foo@bar.com',
        password: 'password',
        role: 'owner'
    }
  end

  describe "POST /signup" do
    before { }
  end
end
