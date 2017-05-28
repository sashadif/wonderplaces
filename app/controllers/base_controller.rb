class BaseController < ApplicationController
  
  private
    
  def authenticate_manager!
    authenticate_user!
    unless current_user&.admin?
      redirect_to '/'
    end
  end
end
