class VetsApi::Pet < VetsApi
  def create_pet
    response = HTTParty.post("#{@api_url}/pets/create" , body: @params, headers: @header)
  end
end