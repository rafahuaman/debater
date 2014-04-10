require 'spec_helper'

describe "argument_posts/new" do
  before(:each) do
    assign(:argument_post, stub_model(ArgumentPost,
      :content => "MyText",
      :user_id => 1,
      :debate_id => 1,
      :type => ""
    ).as_new_record)
  end

  it "renders new argument_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", argument_posts_path, "post" do
      assert_select "textarea#argument_post_content[name=?]", "argument_post[content]"
      assert_select "input#argument_post_user_id[name=?]", "argument_post[user_id]"
      assert_select "input#argument_post_debate_id[name=?]", "argument_post[debate_id]"
      assert_select "input#argument_post_type[name=?]", "argument_post[type]"
    end
  end
end
