require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do
    it "should have content 'Debater Project'" do
      visit root_path
      expect(page).to have_content('Debater Project')
    end
  end
  
  describe "About page" do
    it "should have content 'About Us'" do
      visit about_path
      expect(page).to have_content('About Us')
    end
  end
end
