module ChamberUtility
  def valid_new_chamber_form_completion(new_chamber_information)
    fill_in "Name", with: new_chamber_information[:name]
    fill_in 'Description', with: new_chamber_information[:description]
  end
  
  RSpec::Matchers.define :have_new_chamber_page_appearance do
    match do |page|
      expect(page).to have_title('Create a chamber')
      expect(page).to have_content('Create a chamber')
      expect(page).to have_content('Description')
      expect(page).to have_selector(:link_or_button, 'Create')
    end
  end

  RSpec::Matchers.define :have_invalid_new_chamber_with_blanks_message do
    match do |page|
      expect(page).to have_selector("div.alert-box", text: "Please review the problems below:")
      expect(page).to have_content("can't be blank")
    end
  end

  RSpec::Matchers.define :have_chamber_show_page_appearance do |new_chamber_information|
    match do |page|
      expect(page).to have_content(new_chamber_information[:name])
      expect(page).to have_content(new_chamber_information[:description])
    end
  end

  RSpec::Matchers.define :have_chamber_created_successfully_message do
    match do |page|
      expect(page).to have_selector("div.alert-box", text: "Chamber was successfully created")
    end
  end  
  
  RSpec::Matchers.define :have_links_to_chamber_debates do |debate|
    match do |page|
      expect(page).to have_link(debate.title, debate_path(debate))
    end
  end  
  

end