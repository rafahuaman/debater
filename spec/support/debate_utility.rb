module DebateUtility
  RSpec::Matchers.define :have_invalid_new_debate_with_blanks_message do
	  match do |page|
      expect(page).to have_selector("div.alert-box", text: "Please review the problems below:")
	    expect(page).to have_content("can't be blank")
	  end
	end
end