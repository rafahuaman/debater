require 'spec_helper'

describe "argument_posts/edit" do
  before(:each) do
    @argument_post = assign(:argument_post, stub_model(ArgumentPost,
      :content => "MyText",
      :user_id => 1,
      :debate_id => 1,
      :type => ""
    ))
  end

  it "renders the edit argument_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", argument_post_path(@argument_post), "post" do
      assert_select "textarea#argument_post_content[name=?]", "argument_post[content]"
    end
  end
end
