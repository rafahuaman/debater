require 'spec_helper'

describe "Authentication" do
  let(:user) { FactoryGirl.create(:user) }
  
  subject { page }
  
  describe "sign in page" do
    before { visit signin_path }
    
    it { should have_sign_in_page_appearance }
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
    describe "As non-signed-in user" do
      
      describe "User" do
      
        describe "Pages" do
          describe "when visiting the edit page" do
            before { visit edit_user_path(user) }
          
            it { should have_title("Sign in") }
            
            describe "after signing-in should redirect to previous page" do
              before do 
                valid_signin_form_completion(user)
                click_button "Sign in"
              end
              it { should have_title("Edit user") }
            end
          end
        end
        
        describe "Controller" do
        
          describe "submitting to the update action" do
            before { patch user_path(user) }
            it { should respond_by_redirecting_to_sign_in_page }
          end
          
          describe "submitting to the destroy action" do
            before { delete user_path(user) }
            it { should respond_by_redirecting_to_sign_in_page }
          end
        end
      end
      
      describe "Debates" do
        
        describe "Pages" do
          
          describe "when visiting the create page" do
            before { visit new_debate_path }
            
            it { should have_sign_in_page_appearance }
          end
          
          describe "when visiting the edit page" do
            let(:debate) { FactoryGirl.create(:debate) }
            before { visit new_debate_path(debate) }
            
            it { should have_sign_in_page_appearance }
          end
          
        end
        
        describe "Controller" do
          let(:debate) { FactoryGirl.create(:debate) }
          
          describe "submitting a POST request to the create action" do
            before { post debates_path }
            it { should respond_by_redirecting_to_sign_in_page }
          end
          
          describe "submitting a GET request to the edit action" do
            before { get edit_debate_path(debate) }
            it { should respond_by_redirecting_to_sign_in_page }
          end
          
          describe "submitting a PATCH request to the update action" do
            before { patch debate_path(debate) }
            it { should respond_by_redirecting_to_sign_in_page }
          end
          
          describe "submitting a DELETE to the destroy action" do
            before { delete debate_path(debate) }
            it { should respond_by_redirecting_to_sign_in_page }
          end
        end
      end

      describe "ArgumentPost" do

        describe "when visiting the create page" do
            before { visit new_argument_post_path }
            it { should have_sign_in_page_appearance }
        end

        describe "when visiting the edit page" do
            let(:debate) { FactoryGirl.create(:debate) }
            let(:argument_post) { FactoryGirl.create(:original_post, debate: debate, user: User.find_by(id: debate.user_id)) }
            before { visit edit_debate_path(argument_post) }
            
            it { should have_sign_in_page_appearance }
          end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit new_debate_path
          fill_in "Name",    with: user.name
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do
           it "should render the desired protected page" do
             expect(page).to have_title('Submit a debate')
           end

           describe "when signing in again" do
            before do
              click_link "Sign out"
              visit signin_path
              fill_in "Name",    with: user.name
              fill_in "Password", with: user.password
              click_button "Sign in"
            end

            it "should render the default (root) page" do
              expect(current_path).to eq(root_path)
            end
             
           end

          
        end
        
      end
    end
    
    describe "as wrong user" do
      let(:wrong_user) { FactoryGirl.create(:user, name: "Matt") }
      before { sign_in user, no_capybara: true}
      
      describe "User Controller" do
        describe "submitting a GET request to the #edit action" do
          before { get edit_user_path(wrong_user) }
          it { should respond_by_redirecting_to_root_page }
        end
        
        describe "submitting a PATCH request to the #update action" do
          before { patch user_path(wrong_user) }
          it { should respond_by_redirecting_to_root_page }
        end
        
        describe "submitting a DELETE request to the #delete action" do
          before { delete user_path(wrong_user) }
          it { should respond_by_redirecting_to_root_page }
        end
      end
      
      describe "Debate Controller" do
        let(:debate) { FactoryGirl.create(:debate, user: wrong_user) }
        
        describe "submitting a GET request to the #edit action" do
          before { get edit_debate_path(debate) }
          it { should respond_by_redirecting_to_root_page }
        end
        
        describe "submitting a PATCH request to the #update action" do
          before { patch debate_path(debate) }
          it { should respond_by_redirecting_to_root_page }
        end
        
        describe "submitting a DELETE request to the #delete action" do
          before { delete debate_path(debate) }
          it { should respond_by_redirecting_to_root_page }
        end
      end

      describe "ArgumentPost Controller" do
        let(:debate) { FactoryGirl.create(:debate, user: wrong_user) }
        let(:argument_post) { FactoryGirl.create(:original_post, debate: debate,  user: wrong_user) }
        
        describe "submitting a GET request to the #edit action" do
          before { get edit_argument_post_path(argument_post) }
          it { should respond_by_redirecting_to_root_page }
        end
        
        describe "submitting a PATCH request to the #update action" do
          before { patch argument_post_path(argument_post) }
          it { should respond_by_redirecting_to_root_page }
        end
        
        describe "submitting a DELETE request to the #delete action" do
          before { delete argument_post_path(argument_post) }
          it { should respond_by_redirecting_to_root_page }
        end
      end
      
    end
  end
  
end
