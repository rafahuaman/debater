require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        name: "Dave",
        password: "foobar",
        password_confirmation: "foobar"
      ),
      stub_model(User,
        name: "Matt",
        password: "foobar",
        password_confirmation: "foobar"
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Dave".to_s, :count => 1
    assert_select "tr>td", :text => "Matt".to_s, :count => 1
  end
end
