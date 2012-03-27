require 'spec_helper'

describe Withdrawal do

  let(:account) { create :account }
  let(:withdrawal) { build( :withdrawal, amount: 1, account: account ) }

  context "valdation" do
    [:amount, :account ].each do |col|
      it { should validate_presence_of col }
    end
    it "amount greater than 0" do
      withdrawal.amount = 0.00
      withdrawal.should_not be_valid
    end
  end

  context "account balance" do
    it "should decrease balance for withdrawal" do
      account.save!
      old_balance = account.balance
      withdrawal.save!
      account.reload
      account.balance.should == old_balance - withdrawal.amount
    end
    it "should block balance update if allow_debit is false" do
      account.save
      withdrawal.amount = account.balance + 200
      withdrawal.should_not be_valid
      withdrawal.save.should_not == true
    end
  end

end
