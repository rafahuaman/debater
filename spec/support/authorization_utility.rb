module AuthorizationUtility
  RSpec::Matchers.define :have_sign_in_page_appearance do
	  match do |page|
      expect(page).to have_title('Sign in')
      expect(page).to have_content('Sign in')  
      expect(page).to have_link('Sign up!', href: signup_path) 
	  end
	end
  
  RSpec::Matchers.define :respond_by_redirecting_to_sign_in_page do
	  match do |page|
      expect(response).to redirect_to(signin_path)
	  end
	end
  
  RSpec::Matchers.define :respond_by_redirecting_to_root_page do
	  match do |page|
      expect(response).to redirect_to(root_path)
	  end
	end
end