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
  its(:user) { should eq user }

  it { should be_valid }
  
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

