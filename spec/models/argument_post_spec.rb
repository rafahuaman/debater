require 'spec_helper'

describe ArgumentPost do
  let(:user) { FactoryGirl.create(:user, name: "Paul")  }
  let(:chamber) { FactoryGirl.create(:chamber)  }
  let(:debate) { FactoryGirl.create(:debate)  }
  
  before do
    @argument_post = user.argument_posts.build(content: "Lorem Ipsum", debate_id: debate.id, type: "OriginalPost", position: "affirmative")
  end
  
  subject { @argument_post }
  
  it { should respond_to(:content) }
  it { should respond_to(:user) }
  it { should respond_to(:debate) }
  it { should respond_to(:type) }
  it { should respond_to(:position) }
  its(:user) { should eq user }
  its(:debate) { should eq debate }
  
  it { should be_valid }
  
  describe "when user is missing" do 
    before { @argument_post.user = nil }
    it { should_not be_valid } 
  end
  
  describe "when debate is missing" do 
    before { @argument_post.debate = nil }
    it { should_not be_valid } 
  end
  
  describe "type" do
    describe "when it is missing" do 
      before { @argument_post.type = nil }
      it { should_not be_valid } 
    end
    
    describe "when it is an invalid type" do 
      before { @argument_post.type = "Invalid" }
      it { should_not be_valid } 
    end
  end
  
  describe "content" do
    describe "when it is missing" do 
      before { @argument_post.content = nil }
      it { should_not be_valid } 
    end
    
    describe "when it is blank" do 
      before { @argument_post.content = " " }
      it { should_not be_valid } 
    end
    
    describe "when it is too long" do
      before { @argument_post.content = "a"*5001 }
      it { should_not be_valid }
    end
  end  
  
end
