require 'spec_helper'

describe Vote do
  let(:user) { FactoryGirl.create(:user) }
  let(:debate) { FactoryGirl.create(:debate, user: user) }
  let(:original_post) { FactoryGirl.create(:original_post, user: user, debate: debate) }
  
  before do
    @DebateVote = user.votes.build(votable_type: "Debate", 
                      votable_id: debate.id, value: 1)
    @ArgumentVote = user.votes.build(votable_type: "ArgumentPost", 
                      votable_id: original_post.id, value: 1)
  end

  subject { @DebateVote }

  it { should respond_to(:votable_type) }
  it { should respond_to(:votable_id) }
  it { should respond_to(:user) }
  it { should respond_to(:value) }
  its(:user) { should eq user }
  its(:votable) { should eq debate }

  it { should be_valid }

  describe "when user is missing" do 
      before { @DebateVote.user = nil }
      it { should_not be_valid } 
  end

  describe "votable_type" do
    describe "when type is missing" do 
      before { @DebateVote.votable_type = nil }
      it { should_not be_valid } 
    end

    describe "when it is invalid" do    
      before { @DebateVote.votable_type = "Invalid" }
      it { should_not be_valid } 
    end
  end
  

  describe "when votable_id is missing" do 
      before { @DebateVote.votable_id = nil }
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
end

