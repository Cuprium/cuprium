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
    let(:conversion) { create :currency_conversion, currency_code: 'XX2', valid_from: Time.now, factor: 3 }


    it "should execute OK" do
      from_balance = from_account.balance
      to_balance = to_account.balance
      transfer = Transfer.new(from_account:from_account,to_account:to_account,amount:1).execute
      new_from = Account.find from_account.number
      new_to = Account.find to_account.number
      new_to.balance.should == to_balance + 1
      new_from.balance.should == from_balance - 1
    end

    it "should set the currency conversion if it was converted" do
      to_account.currency_code = conversion.currency_code
      to_account.save!
      from_balance = from_account.balance
      to_balance = to_account.balance
      transaction = Transfer.new(from_account:from_account,to_account:to_account,amount:1).execute
      new_from = Account.find from_account.number
      new_to = Account.find to_account.number
      new_to.balance.should == to_balance + (1 * conversion.factor)
      new_from.balance.should == from_balance - 1
      transaction.to_conversion.should == to_account.current_conversion
      transaction.from_conversion.should == from_account.current_conversion
    end
  end
end
