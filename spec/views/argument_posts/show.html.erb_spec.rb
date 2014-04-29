require 'spec_helper'

describe "argument_posts/show" do
  before do
    @argument_post = FactoryGirl.create(:original_post) 
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(@argument_post.content)
  end
end
