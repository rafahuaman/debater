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

          it { should have_link("contribute") }
          it { should have_link("rectify") }
          it { should have_link("counter") }
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
    end
  end

  describe "Edit an argument post" do
    let(:edit) { "edit"}
    let(:submit)  { "Post" }
    let(:original_content)  { "Orignal Post Content" }
    let(:edited_content)  { "Edited Post Content" }
    let!(:argument_post) { FactoryGirl.create(:original_post, content: original_content, debate: debate, user: user) }

    describe "as a valid user" do
      before do
        sign_in user
        visit debate_path(debate)
      end

      it { should have_link(edit) }

      describe "should save changes" do
        before do
          click_link edit
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

      it { should_not have_link(edit) }
    end
    
  end

  describe "Reply as Contribution to an Argument Post" do
    let(:contribute) { "contribute"}
    let(:submit)  { "Post" }
    let!(:affirmative_post) { FactoryGirl.create(:original_post, debate: debate, user: user) }
    before do
      sign_in user
      visit debate_path(debate)
      click_link contribute
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
        expect(find("div.argument-post##{affirmative_post.id}")).to have_content('Valid Contribution')
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
              expect(find("div.argument-post##{affirmative_post.id}").text).to match(/(#{affirmative_post.content}#{contribution_post.user.name}: #{contribution_post.content})/)
            end
          end
        end
      end 
    end
  end
  describe "Reply as Correction to an Argument Post" do
    let(:add_correction) { "rectify" }
    let(:submit)  { "Post" }
    let!(:incorrect_post) { FactoryGirl.create(:original_post, debate: debate, user: user, content: "Incorrect information") }
    before do
      sign_in user
      visit debate_path(debate)
      click_link add_correction
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
        expect(find("div.argument-post##{incorrect_post.id}")).to have_content(correct_content)
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
              expect(find("div.argument-post##{incorrect_post.id}").text).to match(/(#{correction_post.content}Corrected by: #{correction_post.user.name})/)
            end

            describe "Multiple Corrections" do
              let(:additional_correction_text) { "Better information" }
              let!(:additional_correction) { FactoryGirl.create(:correction_post, debate: debate, user: user, parent: incorrect_post, content: additional_correction_text) }
              before do 
                visit debate_path(debate)
                within("div.argument-post##{additional_correction.id}") do
                  click_link correction_link
                end
              end

              it "display a list of correction authors " do
                expect(find("div.argument-post##{incorrect_post.id}").text).to match(/(#{additional_correction_text}Corrected by: #{correction_post.user.name}, #{additional_correction.user.name})/)
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
      click_link "counter"
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
        let(:last_post) { CounterArgumentPost.last }
        it { should have_link("see counterarguments") }
        
        it "should list all counterarguments " do
          expect(find("li#counter-ref-link-#{last_post.id}")).to have_content("1")
        end
      end
    end
  end

  describe "voting" do
    let!(:argument_post) { FactoryGirl.create(:original_post, content: "Test content", debate: debate, user: user) }

    describe "buttons" do
      describe "as non signed-in user" do
        describe "without votes" do
          before do
            visit debate_path(debate)
          end
          it { should have_selector('.argument-post-vote-button.upvote.unclicked') }
          it { should have_selector('.argument-post-vote-button.downvote.unclicked') }
        end

        describe "with votes" do
          before do
            sign_in user
            user.upvote!(argument_post)
            click_link 'Sign out' 
            visit debate_path(debate)
          end
          it { should have_selector('.argument-post-vote-button.upvote.unclicked') }
          it { should have_selector('.argument-post-vote-button.downvote.unclicked') }
        end
      end


      describe "after signing in" do
        before do
          sign_in user
          visit debate_path(debate)
        end

        describe "without votes" do
          it { should have_selector('.argument-post-vote-button.upvote.unclicked') }
          it { should have_selector('.argument-post-vote-button.downvote.unclicked') }
          it "should have a 0 score" do
            expect(find("#argument-post-card-#{argument_post.id}").find(".argument-post-score")).to have_content(0)
          end

          describe "Clicking the upvote link" do
            it "should increment the debate score" do
              find("#argument-post-card-#{argument_post.id}").find(".argument-post-vote-button.upvote.unclicked").find('a').click
              expect(find("#argument-post-card-#{argument_post.id}").find(".argument-post-score")).to have_content(1)
            end

            describe "Twice" do
              it "should destroy the vote" do
                find("#argument-post-card-#{argument_post.id}").find(".argument-post-vote-button.upvote.unclicked").find('a').click
                find("#argument-post-card-#{argument_post.id}").find(".argument-post-vote-button.upvote.clicked").find('a').click
                expect(find("#argument-post-card-#{argument_post.id}").find(".argument-post-score")).to have_content(0)
              end
            end
          end

          describe "Clicking the downvote link" do
            it "should decrement the debate score" do
              find("#argument-post-card-#{argument_post.id}").find(".argument-post-vote-button.downvote.unclicked").find('a').click
              expect(find("#argument-post-card-#{argument_post.id}").find(".argument-post-score")).to have_content(-1)
            end
          end
        end

        describe "after voting" do
          before do
            user.vote!(argument_post,1)
            visit debate_path(debate)
          end
          it { should have_selector('div.argument-post-score', text: 1) }

          it { should have_selector('.argument-post-vote-button.upvote.clicked') }
          it { should have_selector('.argument-post-vote-button.downvote.unclicked') }

          describe "followed by downvote" do
            before do 
              user.downvote!(argument_post) 
              visit debate_path(debate)
            end
            it { should have_selector('.argument-post-vote-button.upvote.unclicked') }
            it { should have_selector('.argument-post-vote-button.downvote.clicked') }
            it { should have_selector('div.argument-post-score', text: -1) }
          end
        end
      end
    end
  end

  describe "display order" do
    let!(:unpopular_positive_argument) { FactoryGirl.create(:original_post, content: "unpopular positive post", debate: debate, user: user) }
    let!(:popular_positive_argument) { FactoryGirl.create(:original_post, content: "popular positive post", debate: debate, user: user) }
    let!(:unpopular_negative_argument) { FactoryGirl.create(:original_post, position: "negative", content: "unpopular negative post", debate: debate, user: user) }
    let!(:popular_negative_argument) { FactoryGirl.create(:original_post, position: "negative", content: "popular negative post", debate: debate, user: user) }
    

    before do
      sign_in user
      user.upvote!(popular_positive_argument)
      user.downvote!(unpopular_positive_argument)
      user.upvote!(popular_negative_argument)
      user.downvote!(unpopular_negative_argument)
      visit debate_path(debate)
    end

    it { should have_content(popular_positive_argument.content) }
    it { should have_content(unpopular_positive_argument.content) }
    it { should have_content(unpopular_negative_argument.content) }
    it { should have_content(popular_negative_argument.content) }

    it "should be determined by score" do
      expect(page.body.index(popular_positive_argument.content)).to be < page.body.index(unpopular_positive_argument.content)
      expect(page.body.index(popular_negative_argument.content)).to be < page.body.index(unpopular_negative_argument.content)
    end
  end
end



