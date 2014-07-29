require 'spec_helper'

describe Vote do
  let(:user) { FactoryGirl.create(:user) }
  let(:debate) { FactoryGirl.create(:debate, user: user) }
  let(:original_post) { FactoryGirl.create(:original_post, user: user, debate: debate) }
  
  before do
    @DebateVote = user.votes.build(type: "DebateVote", 
                      subject_id: debate.id, value: 1)
    @ArgumentVote = user.votes.build(type: "ArgumentVote", 
                      subject_id: original_post.id, value: 1)
  end

  subject { @DebateVote }

  it { should respond_to(:type) }
  it { should respond_to(:subject_id) }
  it { should respond_to(:user) }
  it { should respond_to(:value) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user is missing" do 
      before { @DebateVote.user = nil }
      it { should_not be_valid } 
  end

  describe "type" do
    describe "when type is missing" do 
      before { @DebateVote.type = nil }
      it { should_not be_valid } 
    end

    describe "when it is invalid" do    
      before { @DebateVote.type = "Invalid" }
      it { should_not be_valid } 
    end
  end
  

  describe "when subject_id is missing" do 
      before { @DebateVote.subject_id = nil }
      it { should_not be_valid } 
  end 

  describe "value" do
    describe "when value is missing" do 
      before { @DebateVote.value = nil }
      it { should_not be_valid } 
    end

    describe "should only have 1 and -1 values" do
      before { @DebateVote.value = 2 }
      it { should_not be_valid } 
    end
  end

  describe "User can only vote once on any subject" do
    before do
      vote_copy = @DebateVote.dup
      vote_copy.value = -1
      vote_copy.save
    end 
    it { should_not be_valid }
  end
  
  describe "DebateVote" do
    it { should respond_to(:debate) }
    its(:debate) { should eq debate }
  end

  describe "ArgumentVote" do
    subject { @ArgumentVote }
    it { should respond_to(:argument_post) }
    its(:argument_post) { should eq original_post }
  end


end

