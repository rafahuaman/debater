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
  
  describe "create" do

  end
  
  describe "show" do
        before { visit debate_path(debate) }
    
    it { should have_content(debate.title) }
    it { should have_content(debate.content) }
    it { should have_content(debate.affirmative) }
    it { should have_content(debate.negative) }
    
  end
  
  
end
