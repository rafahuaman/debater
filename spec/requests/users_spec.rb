require 'spec_helper'

describe "User pages" do
  
  subject { page }

  describe "signup page" do
    before { visit new_user_path }

    it { should have_content('New user') }
    #it { should have_title(full_title('Sign up')) }
  end
end
