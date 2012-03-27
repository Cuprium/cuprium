require 'spec_helper'

describe Transfer do
  context "invalid operations" do
    it "should reject same from/to account" do
      lambda {
        Transfer.new(from_account:'test-acc-1',to_account:'test-acc-1',amount:1).execute
      }.should raise_error Transfer::SameAccount
    end
    it "should reject nil from account" do
      lambda {
        Transfer.new(to_account:'test-acc-1',amount:1).execute
      }.should raise_error Transfer::NilAccount
    end
    it "should reject nil to account" do
      lambda {
        Transfer.new(from_account:'test-acc-1',amount:1).execute
      }.should raise_error Transfer::NilAccount
    end
    it "should reject nil amount" do
      lambda {
        Transfer.new(from_account:'test-acc-1',to_account:'test-acc-2').execute
      }.should raise_error Transfer::InvalidAmount
    end
    it "should reject non-positive amount" do
      lambda {
        Transfer.new(from_account:'test-acc-1',to_account:'test-acc-2',amount:0).execute
      }.should raise_error Transfer::InvalidAmount
    end
  end
  context "do an actual transfer" do
    let(:from_account) { create :account, number:'test-acc-10' }
    let(:to_account) { create :account, number:'test-acc-11' }

    it "should execute OK" do
      from_balance = from_account.balance
      to_balance = to_account.balance
      transfer = Transfer.new(from_account:from_account,to_account:to_account,amount:1).execute
      new_from = Account.find from_account.number
      new_to = Account.find to_account.number
      new_to.balance.should == to_balance + 1
      new_from.balance.should == from_balance - 1
    end
  end
end
