module AuthorizationUtility
  RSpec::Matchers.define :redirect_to_sign_in_page do
	  match do |page|
      expect(page).to have_title('Sign in')
	  end
	end
end