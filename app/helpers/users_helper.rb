module UsersHelper 
  def user_sign_in?
    if session[:userkey]
      @user = User.find_by(id: session[:userkey])
    end
  end
end