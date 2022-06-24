class ApplicationController < ActionController::Base
  before_action :set_header
  before_action :set_api_url
  private 
  def set_header 
    @header = {
      'Authorization': cookies[:token]
    }
  end

  def set_api_url
    @api_url = 'http://localhost:3000'
  end
end
