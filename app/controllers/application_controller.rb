class ApplicationController < ActionController::Base
  include UserHelper
  include Pundit

  rescue_from Pundit::NotAuthorizedError do 
    flash[:notice] = 'Oops! You do not have access to this page'
    redirect_to request.referrer || root_path
  end
end
