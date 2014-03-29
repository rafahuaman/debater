require 'spec_helper'

describe "chambers/show" do
  before(:each) do
    @chamber = assign(:chamber, stub_model(Chamber,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
