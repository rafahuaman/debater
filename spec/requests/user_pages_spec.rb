require 'spec_helper'

describe "User pages" do
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
      before { valid_signup_form_completion }
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
    
    
    
  end
end
