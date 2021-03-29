class ApplicationController < ActionController::Base
  include UserHelper
  include Pundit
end
