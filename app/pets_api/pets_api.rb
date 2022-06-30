class PetsApi
  def initialize(token='', params: {})
    @header = {'Authorization': token}
    @params = params
    @api_url = 'http://localhost:3000'
  end

  class UsersApi < PetsApi
    def get_user
      response = HTTParty.get("#{@api_url}/user", headers: @header)
      response.parsed_response 
    end

    def create_user
      response = HTTParty.post("#{@api_url}/signup", body:@params)
    end
  end
end






