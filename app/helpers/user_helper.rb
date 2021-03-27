module UserHelper 
  def user_sign_in?
    if current_user
      return true
    else
      return false
    end
  end

  def current_user
    if session[:userkey].present?
      @user ||= User.find_by(id: session[:userkey])
    else
      nil
    end
  end
end