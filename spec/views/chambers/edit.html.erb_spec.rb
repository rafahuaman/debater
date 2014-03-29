require 'spec_helper'

describe "chambers/edit" do
  before(:each) do
    @chamber = assign(:chamber, stub_model(Chamber,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit chamber form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", chamber_path(@chamber), "post" do
      assert_select "input#chamber_name[name=?]", "chamber[name]"
      assert_select "textarea#chamber_description[name=?]", "chamber[description]"
    end
  end
end
