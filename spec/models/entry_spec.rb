require 'spec_helper'

describe Entry do

  let(:account) { build(:account) }
  let(:entry) { build( :entry ) }

  context "valdation" do
    [:direction,:name].each do |col|
      it { should validate_presence_of col }
    end
    it "direction should initialize at 1" do
      Entry.new.direction == 1
    end
    it "direction must be 1 or -1" do
      entry.direction = 1
      entry.should be_valid
      entry.direction = -1
      entry.should be_valid
      entry.direction = 0
      entry.should_not be_valid
    end
  end

end
