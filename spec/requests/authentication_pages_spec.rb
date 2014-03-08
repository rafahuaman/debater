require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  
  describe "sign in page" do
    before { visit signin_path }
    
    it { should have_content('Sign in')  }
    it { should have_title('Sign in')  }
    it { should have_link('Register', href: signup_path)  }
  end
  
  describe "sign in" do
    before { visit signin_path }
    
    let(:submit) { "Sign in" }
    
    describe "with invalid username and password" do
      before { click_button submit }
      it { should have_selector('div.alert-box.alert') }
    end
    
    describe "with valid username and password" do
      let(:user) { FactoryGirl.create(:user) }
      before do 
        fill_in "Name", with: "Dave"
        fill_in 'Password', with: "foobar"
        click_button submit 
      end
      it { should have_selector("div.alert-box", text: "Please review the problems below:") }
      it { should  have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link("Sign in", href: sigin_path)}
    end
    
  end
  
end
