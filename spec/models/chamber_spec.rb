require 'spec_helper'

describe Chamber do
  before do 
    @chamber = Chamber.new(name: "Example",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
      Pellentesque enim tellus, tempor ut diam sagittis, tincidunt elementum 
      odio. Sed et magna in felis tempor sodales. Cras porttitor nisl vel 
      enim viverra pretium vitae commodo nunc. Donec dapibus diam non odio 
      fermentum, non dignissim massa consectetur. Vestibulum ante ipsum 
      primis in faucibus orci luctus et ultrices posuere cubilia Curae; Etiam 
      id purus nisl. Nulla sed purus non turpis sagittis commodo. Nullam varius 
      augue ut ultricies egestas. Vivamus mi diam, posuere iaculis augue eu, 
      imperdiet adipiscing ipsum. Sed eros leo, dignissim eget dapibus in, 
      ultrices non est. Mauris ornare mi vel mi euismod euismod. Nam molestie 
      felis vitae dolor sollicitudin rutrum. Morbi commodo a ligula sit amet 
      malesuada. Cum sociis natoque penatibus et magnis dis parturient montes, 
      nascetur ridiculus mus.")
  end
  
  subject { @chamber }
  
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:debates) }
  
  it { should be_valid }
  
  describe "name" do
    describe "when it is missing" do
      before { @chamber.name = nil }
      it { should_not be_valid }
    end
    
    describe "when it is blank" do
      before { @chamber.name = " " }
      it { should_not be_valid }
    end
    
    describe "when it is a duplicate" do
      before do
        chamber_with_same_name = @chamber.dup 
        chamber_with_same_name.save
      end
      it { should_not be_valid }
    end
  end
  
  describe "description" do
    describe "when it is missing" do
      before { @chamber.description = nil }
      it { should_not be_valid }
    end
    
    describe "when it is blank" do
      before { @chamber.description = " " }
      it { should_not be_valid }
    end
  end

end
