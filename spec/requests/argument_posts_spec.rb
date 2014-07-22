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

  describe "Edit an argument post" do
    let(:submit)  { "Post" }
    let(:original_content)  { "Orignal Post Content" }
    let(:edited_content)  { "Edited Post Content" }
    let!(:argument_post) { FactoryGirl.create(:original_post, content: original_content, debate: debate, user: user) }

    describe "as a valid user" do
      before do
        sign_in user
        visit debate_path(debate)
      end

      it { should have_link("Edit") }

      describe "should save changes" do
        before do
          click_link "Edit"
          fill_in "Content", with: edited_content
          click_button submit
        end

        it { should have_content(edited_content) }
      end
    end

    describe "as wrong user" do
      let(:wrong_user) { FactoryGirl.create(:user, name: "wrong_user" ) }
      before do 
        sign_in wrong_user
        visit debate_path(debate)
      end

      it { should_not have_link("Edit") }
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

      it "should be nested " do
        expect(find("div.argument_post##{affirmative_post.id}")).to have_content('Valid Contribution')
      end

      describe "Accept contribution link" do
        it { should have_link("accept contribution")}

        describe "Visibiility" do
          describe "should not show link if signed out" do
            before do
              click_link "Sign out" 
              visit debate_path(debate)
            end

            it { should_not have_link("accept contribution")}
          end

          describe "should not show link if signed in user does not own parent argument post" do
            let(:other_user) { FactoryGirl.create(:user)  }

            before do
              sign_in other_user
              visit debate_path(debate)
            end

            it { should_not have_link("accept contribution")}    
          end
        end

        describe "Functionality" do
          let!(:contribution_post) { ArgumentPost.last }

          describe "Clik link " do
            before do
              click_link "accept contribution"
            end

            it "should concatenate child post to parent" do
              expect(find("div.argument_post##{affirmative_post.id}").text).to match(/(#{affirmative_post.content}#{contribution_post.user.name}: #{contribution_post.content})/)
            end
          end
        end
      end 
    end
  end
  describe "Reply as Correction to an Argument Post" do
    let(:submit)  { "Post" }
    let!(:incorrect_post) { FactoryGirl.create(:original_post, debate: debate, user: user, content: "Incorrect information") }
    before do
      sign_in user
      visit debate_path(debate)
      click_link "Correction"
    end

    it { should have_content "Post a Correction" }
    it { should have_content incorrect_post.content }
    
    describe "Should create a nested argument post" do
      let(:correct_content) { "Corrected information" }
      before do 
        fill_in "Content", with: correct_content
        click_button submit
      end

      it { should have_debate_show_data(debate) }
      it { should have_content(correct_content) }

      it "should be nested " do
        expect(find("div.argument_post##{incorrect_post.id}")).to have_content(correct_content)
      end

      describe "Accept Correction link" do
        let(:correction_link) { "accept correction" }
        it { should have_link(correction_link)}

        describe "Visibiility" do
          describe "should not show link if signed out" do
            before do
              click_link "Sign out" 
              visit debate_path(debate)
            end

            it { should_not have_link(correction_link)}
          end

          describe "should not show link if signed in user does not own parent argument post" do
            let(:other_user) { FactoryGirl.create(:user)  }

            before do
              sign_in other_user
              visit debate_path(debate)
            end

            it { should_not have_link(correction_link)}    
          end
        end

        describe "Functionality" do
          let!(:correction_post) { ArgumentPost.last }

          describe "Clik link " do
            before do
              click_link correction_link
            end

            it "should replace parent post with child post " do
              expect(find("div.argument_post##{incorrect_post.id}").text).to match(/(#{correction_post.content}Corrected by: #{correction_post.user.name})/)
            end

            describe "Multiple Corrections" do
              let(:additional_correction_text) { "Better information" }
              let!(:additional_correction) { FactoryGirl.create(:correction_post, debate: debate, user: user, parent: incorrect_post, content: additional_correction_text) }
              before do 
                visit debate_path(debate)
                within("div.argument_post##{additional_correction.id}") do
                  click_link correction_link
                end
              end

              it "display a list of correction authors " do
                expect(find("div.argument_post##{incorrect_post.id}").text).to match(/(#{additional_correction_text}Corrected by: #{correction_post.user.name}, #{additional_correction.user.name})/)
              end
            end
          end
        end
      end
    end
  end

  describe "Reply as a counter argument" do
    let(:submit)  { "Post" }
    let!(:affirmative_post) { FactoryGirl.create(:original_post, debate: debate, user: user) }
    before do
      sign_in user
      visit debate_path(debate)
      click_link "Counterargument"
    end

    it { should have_content "Post a Counterargument" }

    describe "Should create an argument post on the opposing side" do
      let(:counter) { "disagreement" }
      before do 
        fill_in "Content", with: counter
        click_button submit
      end

      it { should have_debate_show_data(debate) }
      it { should have_content(counter) }

      it "should be on the opposite side " do
        expect(find("div#negative_posts")).to have_content(counter)
        expect(find("div#affirmative_posts")).not_to have_content(counter)
      end

      describe "counterarguments dropdown" do
        let(:last_post) { ArgumentPost.last }
        it { should have_link("see counterarguments") }
        it { should have_selector("li#counter-link-#{last_post.id}")}
        
        #it "should list all counterarguments " do
         # expect(response).to have_selector("li#counter-link-#{last_post.id}")
        #end
      end
    end
  end
end


