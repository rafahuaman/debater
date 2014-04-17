require 'spec_helper'

describe "Chambers Pages" do
  subject { page }
  let!(:chamber) { FactoryGirl.create(:chamber)  }
  let(:user) { FactoryGirl.create(:user)  }

  describe "index" do
  	before { visit chambers_path }

  	it { should have_link(chamber.name, chamber_path(chamber)) }
  	it { should have_content(chamber.description) }
  end
  
  describe "Create a Chamber" do
  	before do
  		sign_in user
  		visit new_chamber_path 
  	end

  	let(:submit)  { "Create" }

  	it { should have_new_chamber_page_appearance }  

  	describe "with invalid information" do
  	  it "should not create a chamber" do
  		  expect { click_button submit }.not_to change(Chamber, :count)
  	  end

      describe "after submission with blanks" do
        before { click_button submit }
        it { should have_invalid_new_chamber_with_blanks_message }
      end  
  	end

    describe "with valid information" do
      let(:valid_new_chamber_form_data) do 
        { name: "Name",
          description: "description description description description" }
      end

      before { valid_new_chamber_form_completion(valid_new_chamber_form_data) }

      it "should create a chamber" do
        expect{ click_button submit }.to change(Chamber, :count).by(1)
      end
      
    end


          
  end
end
