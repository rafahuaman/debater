require 'spec_helper'

describe "User pages" do
  let(:user) { FactoryGirl.create(:user) }

  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    let(:submit) { "Create my account" }
    
    it { should have_content('Sign up')  }
    it { should have_title('Sign up')  }
        
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
       
      describe "after submission with blanks" do
        before { click_button submit }
        it { should have_invalid_signup_with_blanks_message }
      end
      
    end
    
    describe "with valid information" do
      let(:user_signup_information) { { name: "Example", password: "foobar"} }
      before { valid_signup_form_completion(user_signup_information) }
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        
        it { should have_link('Profile', href: user_path(User.last)) }
        it { should have_link('Sign out', href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path)}        
      end
    end
    
  end
  
  describe "edit" do
    let(:submit) { "Save changes" }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
    end

    describe "with invalid information" do
      before { click_button submit }

      it { should have_selector('div.alert-box.alert') }
    end
    
    describe "with valid information" do
      let(:user_signup_information) { { name: "New Name", password: "New Password"} }
      before do 
        valid_signup_form_completion(user_signup_information) 
        click_button submit
      end
      
      it { should have_content("Name: #{user_signup_information[:name]}") }
      it { should have_selector('div.alert-box.success') }
      specify { expect(user.reload.name).to  eq user_signup_information[:name] }
    end    
  end

  describe "destroy page" do
      let(:submit) { "Save changes" }
      before do
        sign_in user
        visit edit_user_path(user)
        click_button "Delete account"
      end
      
      it { should have_content("Delete my account") }
      it { should have_button("Delete") }
     
    describe "with valid information" do
      before { fill_in "Password", with: user.password }
      it "should delete the user" do
        expect { click_button "Delete" }.to change(User, :count).by(-1)   
        expect(User.find_by(name: user.name )).to be_false
      end
    end
    
    describe "with invalid information" do
      before { fill_in "Password", with: "invalid" }
  
      it "should not delete the user" do
        expect { click_button "Delete" }.not_to change(User, :count).by(-1)
        
      end
    end
  end
  
  describe "profile page" do
    let!(:d1) { FactoryGirl.create(:debate, content:"First debate", user: user) }
    let!(:d2) { FactoryGirl.create(:debate, content:"Second debate", user: user) }
    
    before do 
      sign_in user
      visit user_path(user) 
    end
    
    it { should have_content(user.name) }
    it { should have_title(user.name) }
    
    describe "debates" do
      it { should have_content(d1.title) }
      it { should have_content(d2.title) }
    end
  end

end
