require 'spec_helper'

describe Account do

  let(:account) { build( :account ) }

  context "valdation" do
    [:number,:owner,:type,:balance,:currency_code].each do |col|
      it { should validate_presence_of col }
    end
    it "balance should initialize at 0.00" do
      account.balance == 0.00
    end
  end

  context "relationships" do
    it { should belong_to(:currency) }
  end

  context "filter" do
    before(:each) do
      account.save!
    end
    it "for the given account number" do
      Account.filter_by(account.number).should == [account]
    end
    it "for the given owner" do
      Account.filter_by(account.owner).should == [account]
    end
  end

end
