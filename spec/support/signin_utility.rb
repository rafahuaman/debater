module SignInUtility
  
  def sign_in(user, options={})
    if options[:no_capybara]
      # Sign in when not using Capybara.
      remember_token = User.new_remember_token
      cookies[:remember_token] = remember_token
      user.update_attribute(:remember_token, User.hash(remember_token))
    else
      visit signin_path
      fill_in "Name",    with: user.name
      fill_in "Password", with: user.password
      click_button "Sign in"
    end
  end
  
  def valid_signin_form_completion(user)
    fill_in "Name", with: user.name
    fill_in 'Password', with: user.password
  end
  
end