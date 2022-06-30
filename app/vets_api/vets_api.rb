class VetsApi
  def initialize(token = '', params: {})
    @header = {'Authorization': token}
    @params = params
    @api_url = 'http://localhost:3000'
  end

  class UsersApi < VetsApi
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

  class PetsApi < VetsApi
    def create_pet
      response = HTTParty.post("#{@api_url}/pets/create" , body:@params, headers: @header)
    end
  end

  class RegistrationsApi < VetsApi
    def create_registration
      response = HTTParty.post("#{@api_url}/pets/#{@params[:pet_id]}/register",
      body: {vet_email: @params[:vet_email]}, headers: @header)
    end
  end
end





