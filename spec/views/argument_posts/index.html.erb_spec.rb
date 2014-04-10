require 'spec_helper'

describe "argument_posts/index" do
  before(:each) do
    assign(:argument_posts, [
      stub_model(ArgumentPost,
        :content => "MyText",
        :user_id => 1,
        :debate_id => 2,
        :type => "Type"
      ),
      stub_model(ArgumentPost,
        :content => "MyText",
        :user_id => 1,
        :debate_id => 2,
        :type => "Type"
      )
    ])
  end

  it "renders a list of argument_posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
