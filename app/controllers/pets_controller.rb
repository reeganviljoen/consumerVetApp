class PetsController < ApplicationController
  
  def index
    header = {
      'Authorization': JSON.parse(cookies[:user])['token']
    }
    response = HTTParty.get('http://localhost:3000/user', headers: header)
    @user = JSON.parse(response.to_s)
  end
end
