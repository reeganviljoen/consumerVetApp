class PetsApi::UsersApi < PetsApi
  def get_user
    response = HTTParty.get("#{@api_url}/user", headers: @header)
    response.parsed_response 
  end
end