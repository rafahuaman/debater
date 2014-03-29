require 'spec_helper'

describe "chambers/new" do
  before(:each) do
    assign(:chamber, stub_model(Chamber,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new chamber form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", chambers_path, "post" do
      assert_select "input#chamber_name[name=?]", "chamber[name]"
      assert_select "textarea#chamber_description[name=?]", "chamber[description]"
    end
  end
end
