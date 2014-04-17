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
  	end
    
  end
end
