require 'spec_helper'

describe DataManager do
  let(:data_manager) { build( :data_manager ) }
  [:email,:first_name,:last_name,:title_id].each do |col|
    it { should validate_presence_of col }
  end
  it "validate title_id value in range" do
    data_manager.should be_valid
    data_manager.title_id = -1
    data_manager.should_not be_valid
    data_manager.title_id = Lookup::Title.length
    data_manager.should_not be_valid
  end

  it "returns the appropriate title for the given title_id" do
    Lookup::Title.each_with_index do |title,index|
      data_manager.title_id = index
      data_manager.title.should == title
    end    
  end
  # Create has_title_id module?
end
