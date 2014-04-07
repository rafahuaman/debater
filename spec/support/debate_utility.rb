module DebateUtility
  def valid_new_debate_form_completion(new_debate_information)
    fill_in "Title", with: new_debate_information[:title]
    fill_in 'Content', with: new_debate_information[:content]
    fill_in 'Affirmative', with: new_debate_information[:affirmative]
    fill_in 'Negative', with: new_debate_information[:negative]
    select new_debate_information[:chamber], :from => 'Chamber'
  end
  
  RSpec::Matchers.define :have_new_debate_page_appearance do
	  match do |page|
      expect(page).to have_title('Submit a debate')
      expect(page).to have_content('Submit a debate')
      expect(page).to have_content('Title')
      expect(page).to have_content('Content')
      expect(page).to have_content('Affirmative')
      expect(page).to have_content('Negative')
	  end
	end
  
  RSpec::Matchers.define :have_invalid_new_debate_with_blanks_message do
	  match do |page|
      expect(page).to have_selector("div.alert-box", text: "Please review the problems below:")
	    expect(page).to have_content("can't be blank")
	  end
	end
  
  RSpec::Matchers.define :have_debate_show_data do |debate|
	  match do |page|
      expect(page).to have_content(debate[:title])
      expect(page).to have_content(debate[:content])
      expect(page).to have_content(debate[:affirmative])
      expect(page).to have_content(debate[:negative])
      expect(page).to have_content(debate[:content])
	  end
	end
  
  RSpec::Matchers.define :have_debate_links_for_owner do |debate|
	  match do |page|
      expect(page).to have_link("edit", edit_debate_path(debate))
      expect(page).to have_link("delete", debate_path(debate))
	  end
	end
  
  
  RSpec::Matchers.define :have_debate_created_successfully_message  do
    match do |page|
      expect(page).to have_selector("div.alert-box", text: "Debate was successfully created")
	  end
	end
end