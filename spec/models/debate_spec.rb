require 'spec_helper'

describe Debate do
  let(:user) { FactoryGirl.create(:user)  }
  
  before do
    @debate = user.debates.build(title: "Lorem Ipsum", content:"Lorem Ipsum", affirmative: "Lorem Ipsum", negative: "Lorem Ipsum")
  end
  
  subject { @debate }
  
  it { should respond_to :title }
  it { should respond_to :content }
  it { should respond_to :affirmative }
  it { should respond_to :negative }
  it { should respond_to :user_id }
  it { should respond_to :user }
  it { should respond_to :chamber }
  its(:user) { should eq user }
  
  it { should be_valid }
  
  describe "when the user is not present" do 
    before { @debate.user = nil }
    it { should_not be_valid } 
  end
  
  describe "title" do
    
    describe "when is blank" do 
      before { @debate.title = " " }
      it { should_not be_valid } 
    end
   
    describe "when is too long" do 
      before { @debate.title = "a"*301 }
      it { should_not be_valid } 
    end
  end
  
  describe "content" do
    
    describe "when is blank" do 
      before { @debate.content = "" }
      it { should_not be_valid } 
    end
   
    describe "when is too long" do 
      before { @debate.content = "a"*5001 }
      it { should_not be_valid } 
    end
  end
  
  describe "affirmative" do
    describe "when is blank" do 
      before { @debate.affirmative = "" }
      it { should_not be_valid } 
    end
    
    describe "when is too long" do
      before { @debate.affirmative = "a"*301 }
      it { should_not be_valid } 
    end
  end
  
  describe "negative" do
    describe "when is blank" do 
      before { @debate.negative = "" }
      it { should_not be_valid } 
    end
    
    describe "when is too long" do
      before { @debate.negative = "a"*301 }
      it { should_not be_valid } 
    end
  end
  
  
end
