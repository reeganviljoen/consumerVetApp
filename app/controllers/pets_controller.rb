class PetsController < ApplicationController
  before_action :set_user
  
  def index
    @pets = @user['pets']
  end

  private
  def set_user
    @user = JSON.parse(cookies[:user])
  end
end
