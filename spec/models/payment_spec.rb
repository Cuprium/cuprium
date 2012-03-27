require 'spec_helper'

describe Payment do

  let(:account) { create :account }
  let(:payment) { build( :payment, amount: 1, account: account ) }

  context "valdation" do
    [:amount, :account ].each do |col|
      it { should validate_presence_of col }
    end
    it "amount greater than 0" do
      payment.amount = 0.00
      payment.should_not be_valid
    end
  end

  context "account balance" do
    it "should increase balance for payment" do
      old_balance = account.balance
      payment.save
      changed_account = Account.find account.number
      changed_account.balance.should == old_balance + payment.amount
    end
  end

end
