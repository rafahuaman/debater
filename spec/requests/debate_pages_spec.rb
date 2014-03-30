require 'spec_helper'

describe "Debate pages" do
  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user)  }
    let!(:debate) { FactoryGirl.create(:debate, title: "test title", user: user) }
    before do 
      #@debate = FactoryGirl.create(:debate, title: "test title")
      visit root_path 
    end
    
    
    #it { should have_content("#{@debate.title}") } 
      
      
    #it { should have_link("#{@debate.title}") }
    it { should have_link("#{debate.title}", debate_path(debate)) }
      
    
  end
  
  describe "create" do
  end
  
  describe "show" do
  end
  
  
end
