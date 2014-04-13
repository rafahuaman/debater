require 'spec_helper'

describe "Argument Post Pages" do
  subject { page }
  let(:chamber) { FactoryGirl.create(:chamber)  }
  let(:user) { FactoryGirl.create(:user)  }
  let!(:debate) { FactoryGirl.create(:debate) }

  describe "Create a new Argument Post" do
    before do
      sign_in user
      visit debate_path(debate)
    end
    
    let(:submit_affirmative)  { "Post to the Affirmative" }
    let(:submit_nagative)  { "Post to the Negative" }

    it { should have_link(submit_affirmative)  }
    it { should have_link(submit_nagative)  }
    
    describe "with invalid information" do
      before do 
        click_link submit_affirmative
        fill_in "Content", with: "Lorem Ipsum"
      end
      #TODO

    end

  end
end

