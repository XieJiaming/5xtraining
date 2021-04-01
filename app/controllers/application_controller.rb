class ApplicationController < ActionController::Base
  include UserHelper
  include Pundit

  rescue_from Pundit::NotAuthorizedError do 
    redirect_to request.referrer || root_path, notice: 'Oops! You do not have access to this page'
  end
end
