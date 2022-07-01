class VetsApi::Registration < VetsApi
  def create_registration
    response = HTTParty.post("#{@api_url}/pets/#{@params[:pet_id]}/register",
    body: {vet_email: @params[:vet_email]}, headers: @header)
  end

  def accept_registration 
    response = HTTParty.post("#{@api_url}/registrations/#{@params[:id]}", headers: @header)
  end
end