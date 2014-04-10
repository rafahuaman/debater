require 'spec_helper'

describe ArgumentPost do
  let(:user) { FactoryGirl.create(:user, name: "Paul")  }
  let(:chamber) { FactoryGirl.create(:chamber)  }
  let(:debate) { FactoryGirl.create(:debate)  }
  
  before do
    @argument_post = user.argument_posts.build(content: "Lorem Ipsum", debate_id: debate.id, type: "OriginalPost")
  end
  
  subject { @argument_post }
  
  it { should respond_to(:content) }
  it { should respond_to(:user) }
  it { should respond_to(:debate) }
  it { should respond_to(:type) }
  
  it { should be_valid }
  
end
