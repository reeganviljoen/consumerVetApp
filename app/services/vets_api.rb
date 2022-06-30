class VetsApi
  def initialize(token = '', params: {})
    @header = {'Authorization': token}
    @params = params
    @api_url = 'http://localhost:3000'
  end 
end






