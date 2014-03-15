module SessionsHelper
  def sign_in(user)
    remember_token  = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    hashed_remember_token =  User.hash(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: hashed_remember_token)
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def signed_in?
    !current_user.nil?
  end

  #Generate new remember token in the db in case the cookie has been stolen
  def sign_out
    new_remember_token = User.new_remember_token
    current_user.update_attribute(:remember_token, User.hash(new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def redirect_back_or(default_page)
    redirect_to(session[:return_to] || default_page)
    session.delete(:return_to)
  end
  
  def store_location()
    session[:return_to] = request.url if request.get?
  end
end
