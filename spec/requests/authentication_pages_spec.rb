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
      before { sign_in user }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path)}
      
      describe "followed by sign out" do
        before { click_link 'Sign out' }
        
        it { should have_link('Sign in') }
      end
    end
  end
  
  describe "Authorization" do
    let(:user) { FactoryGirl.create(:user) }
    
    describe "As non-signed-in user" do
      
      describe "User" do
      
        describe "Pages" do
          describe "when visiting the edit page" do
            before { visit edit_user_path(user) }
          
            it { should have_title("Sign in") }
            
            describe "after signing-in should redirect to previous page" do
              before do 
                fill_in "Name",    with: user.name
                fill_in "Password", with: user.password
                click_button "Sign in"
              end
              it { should have_title("Edit user") }
            end
          end
        end
        
        describe "Controller" do
        
          describe "submitting to the update action" do
            before { patch user_path(user) }
            specify { expect(response).to redirect_to(signin_path) }
          end
          
          describe "submitting to the destroy action" do
            before { delete user_path(user) }
            specify { expect(response).to redirect_to(signin_path) }
          end
        end
      end
      
      describe "Debates" do
        describe "Pages" do
          
          describe "when visiting the create page" do
            before { visit new_debate_path }
            
            it { should redirect_to_sign_in_page }
          end
        end
        
        describe "Controller" do
          describe "submitting to the create action" do
            before { post debates_path }
            specify { expect(response).to redirect_to(signin_path) }
          end
          
          describe "submitting to the destroy action" do
            before { delete debate_path(FactoryGirl.create(:debate)) }
            specify { expect(response).to redirect_to(signin_path) }
          end
        end
      end
    end
    
    describe "as wrong user" do
      let(:wrong_user) { FactoryGirl.create(:user, name: "Matt") }
      before { sign_in user, no_capybara: true}
      
      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match('Edit user') }
        specify { expect(response).to redirect_to(root_url) }
      end
      
      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
      
      describe "submitting a DELETE request to the Users#delete action" do
        before { delete user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
      
    end
  end
  
end
