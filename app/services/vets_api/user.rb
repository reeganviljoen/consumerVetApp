class VetsApi::User < VetsApi
  def get_user
    response = HTTParty.get("#{@api_url}/user", headers: @header)
    response.parsed_response 
  end

  def get_vets
    vet_response = HTTParty.get("#{@api_url}/vets", headers: @header)
  end

  def create_user
    response = HTTParty.post("#{@api_url}/signup", body:@params)
  end

  def authenticate
    response = HTTParty.post("#{@api_url}/auth/login", body:@params)
  end
end