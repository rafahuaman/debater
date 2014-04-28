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
    let(:submit_negative)  { "Post to the Negative" }
    let(:submit)  { "Post" }

    it { should have_link(submit_affirmative)  }
    it { should have_link(submit_negative)  }
    
    describe "with invalid information" do
      before do 
        click_link submit_affirmative
      end
      
      it "should not create a debate" do
        expect { click_button submit }.not_to change(ArgumentPost, :count)
      end

      describe "after submission with blanks" do
        before { click_button submit }
        it { should have_invalid_new_debate_with_blanks_message }

        it { should have_selector("div.alert-box", text: "Please review the problems below:") }
        it { should have_content("can't be blank") }
      end  
    end

    describe "with valid information" do

      describe "submit to affirmative" do
        before do 
          click_link submit_affirmative
          fill_in "Content", with: "Valid Debate"
        end

        it "should create an ArgumentPost" do
          expect { click_button submit }.to change(ArgumentPost, :count).by(1)
        end

        describe "should redirect to debate show page after submitting the Argument Post" do
          before { click_button submit } 
          it { should have_debate_show_data(debate) }
        end

        describe "should display the affirmative post" do
          before { click_button submit } 
          it { should have_content("Valid Debate") }

          specify "on the correct debate side" do
            expect(find('div#affirmative_posts')).to have_content('Valid Debate')
            expect(find('div#affirmative_posts')).to have_content(user.name)
          end

          it { should have_link("Contribution") }
          it { should have_link("Correction") }
          it { should have_link("Counterargument") }
        end      
      end

      describe "submit to negative" do
        before do 
          click_link submit_negative
          fill_in "Content", with: "Valid Negative Side"
        end

        it "should create an ArgumentPost" do
          expect { click_button submit }.to change(ArgumentPost, :count).by(1)
        end

        describe "should redirect to debate show page after submitting the Argument Post" do
          before { click_button submit } 
          it { should have_debate_show_data(debate) }
        end

        describe "should display the affirmative post" do
          before { click_button submit } 
          it { should have_content("Valid Negative Side") }

          specify "on the correct debate side" do
            expect(find('div#negative_posts')).to have_content('Valid Negative Side')
            expect(find('div#negative_posts')).to have_content(user.name)
          end
        end
      
      end

      describe "submit to negative" do
        before do 
          click_link submit_negative
          fill_in "Content", with: "Valid Debate"
        end

        it "should create an ArgumentPost" do
          expect { click_button submit }.to change(ArgumentPost, :count).by(1)
        end
        
      end
    end
  end

  describe "Reply as Contribution to an Argument Post" do
    let(:submit)  { "Post" }
    let!(:affirmative_post) { FactoryGirl.create(:original_post, debate: debate, user: user) }
    before do
      sign_in user
      visit debate_path(debate)
      click_link "Contribution"
    end

    it { should have_content "Post a Contribution" }

    describe "Should create a nested argument post" do
      before do 
        fill_in "Content", with: "Valid Contribution"
        click_button submit
      end

      it { should have_debate_show_data(debate) }
      it { should have_content("Valid Contribution") }
    end


    
  end



end


