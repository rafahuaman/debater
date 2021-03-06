require 'spec_helper'

describe User do
  
  before do
    @user = User.new(name: "Example User", 
                      password: "foobar", password_confirmation: "foobar")
  end
    
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:debates) }
  it { should respond_to(:argument_posts) }
  it { should respond_to(:chambers) }
  it { should respond_to(:vote!) }
  it { should respond_to(:unvote!) }
  it { should respond_to(:upvote!) }
  it { should respond_to(:downvote!) }
  it { should respond_to(:has_voted_on?) }
  it { should respond_to(:find_vote) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is already taken" do
    before do
      user_with_same_name = @user.dup
      user_with_same_name.save
    end 
    it { should_not be_valid }
  end
  
  describe "when name password is not present" do
    before do
      @user.password  = " "
      @user.password_confirmation  = " " 
    end
    
    it { should_not be_valid }
  end
  
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "when password is too short" do
    before { @user.password = @user.password_confirmation  = "a"*5 }
    it { should_not be_valid }
  end
  
  describe "return value of authentication method" do
    before { @user.save }
    let(:retrieved_user) { User.find_by(name: @user.name) }
    
    describe "with valid password" do
      it { should eq (retrieved_user.authenticate(@user.password)) } 
    end
    
    describe "with invalid password" do
      let(:returned_value_for_invalid_authentication) {retrieved_user.authenticate("invalid")}
      
      it { should_not eq (returned_value_for_invalid_authentication) } 
      specify { expect(returned_value_for_invalid_authentication).to be_false }
    end
    
  end
  
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "debate associations" do 
    before { @user.save }
    let!(:older_debate) do
      FactoryGirl.create(:debate, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_debate) do
      FactoryGirl.create(:debate, user: @user, created_at: 1.hour.ago)
    end
    
     it "should have the right microposts in the right order" do
       expect(@user.debates.to_a).to eq [newer_debate, older_debate]
     end
    
    it "should destroy associated debates" do
      debates = @user.debates.to_a
      @user.destroy
      expect(debates).not_to be_empty
      debates.each do |debate|
        expect(Debate.where(id: debate.id)).to be_empty
      end
    end  
  end

  describe "voting" do
    describe "on Debate" do
      let(:debate) { FactoryGirl.create(:debate) }
      before do 
        @user.save 
        @user.vote!(debate,1)
      end
      its(:votes) { should have(1).items }
      its(:votes) { should eq(debate.votes) }
      it "should create a voting record" do
        expect(@user.has_voted_on?(debate)).to be_true
      end

      it "should find the vote" do
        expect(@user.find_vote(debate)).to eq(debate.votes.last)
      end

      describe "and unvoting" do
        before { @user.unvote!(debate) }
        its(:votes) { should have(0).items }
        
        it "should delete the voting record" do
          expect(@user.has_voted_on?(debate)).to be_false
        end
      end
    end

    describe "on Argument Posts" do
      let(:debate) { FactoryGirl.create(:debate) }
      let(:argument_post) { FactoryGirl.create(:original_post, debate: debate) }
      before do 
        @user.save 
        @user.vote!(argument_post,1)
      end

      its(:votes) { should have(1).items }
      its(:votes) { should eq(argument_post.votes) }
      
      describe "and unvoting" do
        before { @user.unvote!(argument_post) }
        its(:votes) { should have(0).items }
      end
    end

    describe "upvoting" do
      let(:debate) { FactoryGirl.create(:debate) }
      before do
        @user.save 
        @user.upvote!(debate)
        @upvote = Vote.last
      end
      it "should prduce a negative vote" do
          expect(@upvote.value).to eq(1)
      end

      describe "and downvoting" do
        before do
          @user.save 
          @user.downvote!(debate)
          @downvote = Vote.last
        end
        it "should prduce a negative vote" do
          expect(@downvote.value).to eq(-1)
        end
      end
    end
  end
end
  
