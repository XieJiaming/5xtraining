class ApplicationController < ActionController::Base
  include UserHelper
  include Pundit

  before_action :store_locations

  def store_locations
    if(request.path != '/users/sign_in' &&
      request.path != '/users/sing_up' &&
      request.path != '/users/password/new' &&
      request.path != '/users/password/edit' &&
      request.path != '/users/confirmation' && 
      request.path != '/users/sing_out' &&
      !request.xhr?)
      if(session[:previous_url].nil? && session[:previous_previous_url].nil?) 
        session[:previous_previous_url] = nil
        session[:previous_url] = request.fullpath
      else 
        session[:previous_previous_url] = session[:previous_url]
        session[:previous_url] = request.fullpath
      end 
    end
  end

  def after_delete_product
    previous_path = session[:previous_previous_url]
    # session[:previous_url] = nil
    previous_path || root_path
  end


  rescue_from Pundit::NotAuthorizedError do 
    flash[:notice] = 'Oops! You do not have access to this page'
    redirect_to request.referrer || root_path
  end
end
