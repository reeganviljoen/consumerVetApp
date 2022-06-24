class ApplicationController < ActionController::Base
  before_action :set_header
  private 
  def set_header 
    @header = {
      'Authorization': cookies[:token]
    }
  end
end
