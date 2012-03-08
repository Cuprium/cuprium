require 'spec_helper'

describe DataManager do

  let(:data_manager) { build( :data_manager ) }

  context "valdation" do
    [:email,:first_name,:last_name,:title_id].each do |col|
      it { should validate_presence_of col }
    end
    it ". title_id value in range" do
      data_manager.should be_valid
      data_manager.title_id = -1
      data_manager.should_not be_valid
      data_manager.title_id = Lookup::Title.length
      data_manager.should_not be_valid
    end
  end

  context "methods" do
    it "returns the appropriate title for the given title_id" do
      Lookup::Title.each_with_index do |title,index|
        data_manager.title_id = index
        data_manager.title.should == title
      end
    end
    it "gives us the full name" do
      data_manager.full_name.should == "#{data_manager.first_name} #{data_manager.last_name}"
    end
  end

end
