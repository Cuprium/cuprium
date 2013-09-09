require 'spec_helper'

describe Client do
  let(:client) { build(:client) }
  context "valdation" do
    [
      :title_id,
      :first_name,
      :last_name,
      :address1,
      :town,
      :postcode,
    ].each do |col|
      it { should validate_presence_of col }
    end
    it "normalises postcode" do
      client.postcode = 'll189xx'
      client.valid?
      client.postcode.should eq "LL18 9XX"
    end
    it "validates postcode" do
      client.should be_valid
      client.postcode = 'xll189xx'
      client.should_not be_valid
    end
    it "validates email" do
      client.should be_valid
      client.email = 'xll189xx'
      client.should_not be_valid
    end
  end
end
