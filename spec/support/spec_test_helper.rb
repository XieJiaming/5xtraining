module SpecTestHelper   
  def login(user)
    User.log_in(email: user[:email], password: user[:password])
    pwd = user[:password]
    pwd = Digest::SHA1.hexdigest("a#{pwd}z")
    User.find_by(email: user[:email], password: pwd)
    request.session[:userkey] = user[:id]
  end

  def current_user
    User.find(request.session[:userkey])
  end
end