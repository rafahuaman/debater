require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  
  describe "sign in page" do
    before { visit signin_path }
    
    it { should have_content('Sign in')  }
    it { should have_title('Sign in')  }
    it { should have_link('Sign up!', href: signup_path)  }
  end
  
  describe "sign in" do
    before { visit signin_path }
    
    let(:submit) { "Sign in" }
    
    describe "with invalid username and password" do
      before { click_button submit }
      it { should have_selector('div.alert-box.alert') }
      
      describe "after visiting another page" do
        before { click_link "Home" }
        
        it { should_not have_selector('div.alert-box.alert') }
      end
    end
    
    describe "with valid username and password" do
      let(:user) { FactoryGirl.create(:user) }
      before do 
        fill_in "Name", with: user.name
        fill_in 'Password', with: user.password
        click_button submit 
      end
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path)}
      
      describe "followed by sign out" do
        before { click_link 'Sign out' }
        
        it { should have_link('Sign in') }
      end
    end
    
  end
  
end
