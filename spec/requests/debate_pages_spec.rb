require 'spec_helper'

describe "Debate pages" do

  let(:chamber) { FactoryGirl.create(:chamber)  }
  let(:user) { FactoryGirl.create(:user)  }
  let!(:debate) { FactoryGirl.create(:debate, user: user, chamber: chamber) }

  subject { page }

  describe "index" do  
    before { visit root_path }
    
    it { should have_title("Home") }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:debate) } }
      after(:all) do 
        Debate.delete_all 
        User.delete_all
        Chamber.delete_all
      end

       it { should have_selector('ul.pagination.pagination') }

       it "should list each debate" do
        Debate.paginate(page: 1).each do |debate|
          expect(page).to have_selector('li h5', text: debate.title)
        end
      end
    end 
  end
  
  describe "create a new debate" do
    before do 
      sign_in user
      visit new_debate_path 
    end
    
    let(:submit)  { "Post debate" }
    
    it { should have_new_debate_page_appearance  }
    
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
      
      before { valid_new_debate_form_completion(valid_new_debate_form_data) }
      
      it "should create a debate" do
         expect { click_button submit }.to change(Debate, :count).by(1)
      end
      
      describe "should redirect to debate show page after saving the debate" do
        before { click_button submit } 
        it { should have_debate_show_data(valid_new_debate_form_data) }
      end
      
      describe "should show success message after saving the debate" do
        before { click_button submit }
        it { should have_debate_created_successfully_message }
      end
    end

  end
  
  describe "show" do
    before { visit debate_path(debate) }
    
    it { should have_debate_show_data(debate) }
    
    describe "when signed in as debate owner" do
      before do
        sign_in user
        visit debate_path(debate)
      end
      it { should have_debate_links_for_owner }
    end
    
    describe "when not signed in as debate owner" do
      it { should_not have_debate_links_for_owner }
    end
        
  end
  
  
end


