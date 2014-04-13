require 'spec_helper'

describe "argument_posts/new" do
  before(:each) do
    assign(:argument_post, stub_model(ArgumentPost,
      :content => "MyText",
      :user_id => 1,
      :debate_id => 1,
      :type => "OriginalPost",
      :position => "affirmative"
    ).as_new_record)
  end

  it "renders new argument_post form" do
    render position: "affirmative"

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", argument_posts_path, "post" do
      assert_select "textarea#argument_post_content[name=?]", "argument_post[content]"
    end
  end
end
