require 'spec_helper'

describe "argument_posts/show" do
  before(:each) do
    @argument_post = assign(:argument_post, stub_model(ArgumentPost,
      :content => "MyText",
      :user_id => 1,
      :debate_id => 2,
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Type/)
  end
end
