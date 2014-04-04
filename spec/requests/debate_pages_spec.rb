require 'spec_helper'

describe "Debate pages" do
  subject { page }
  
  let(:chamber) { FactoryGirl.create(:chamber)  }
  let(:user) { FactoryGirl.create(:user)  }
  let!(:debate) { FactoryGirl.create(:debate, title: "test title", user: user, chamber: chamber) }

  describe "index" do  
    before { visit root_path }
    
    it { should have_link(debate.title, debate_path(debate)) }
  end
  
  describe "create a new debate" do
    before do 
      sign_in user
      visit new_debate_path 
    end
    
    let(:submit)  { "Post debate" }
    
    it { should have_content('Submit a debate')  }
    it { should have_title('Submit a debate')  }
    
    it { should have_content('Title')  }
    it { should have_content('Content')  }
    it { should have_content('Affirmative')  }
    it { should have_content('Negative')  }
    it { should have_content('Chamber')  }
    
    describe "with invalid information" do
      it "should not create a debate" do
        expect { click_button submit }.not_to change(Debate, :count)
      end
       
      describe "after submission with blanks" do
        before { click_button submit }
        it { should have_invalid_new_debate_with_blanks_message }
      end  
    end
    
    describe "with valid information" do
      let(:valid_new_debate_form_data) do
        { title: "Example", 
          content: "this is my content", 
          affirmative: "For it", 
          negative: "Against it", 
          chamber: chamber[:name] }  
      end
      
      before do
        fill_in "Title", with: valid_new_debate_form_data[:title]
        fill_in 'Content', with: valid_new_debate_form_data[:content]
        fill_in 'Affirmative', with: valid_new_debate_form_data[:affirmative]
        fill_in 'Negative', with: valid_new_debate_form_data[:negative]
        select valid_new_debate_form_data[:chamber], :from => 'Chamber'
      end
      
      it "should create a debate" do
         expect { click_button submit }.to change(Debate, :count).by(1)
      end
      
      it "should redirect after saving the user" do
        expect { click_button submit }.to redirect_to(root_path)
      end
      
    end
    

  end
  
  describe "show" do
        before { visit debate_path(debate) }
    
    it { should have_content(debate.title) }
    it { should have_content(debate.content) }
    it { should have_content(debate.affirmative) }
    it { should have_content(debate.negative) }
    
  end
  
  
end
