require 'spec_helper'

describe Payment do

  let(:account) { create :account }
  let(:payment) { build( :payment, amount: 1, account: account.number ) }

  context "valdation" do
    [:amount, :account, :direction].each do |col|
      it { should validate_presence_of col }
    end
    it "amount greater than 0" do
      payment.amount = 0.00
      payment.should_not be_valid
    end
    it "direction must be 'payment' or 'withdrawal'" do
      payment.direction = 'payment'
      payment.should be_valid
      payment.direction = 'withdrawal'
      payment.should be_valid
      payment.direction = 'rhubarb'
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
    it "should decrease balance for withdrawal" do
      account.save
      old_balance = account.balance
      payment.direction = 'withdrawal'
      payment.save
      changed_account = Account.find account.number
      changed_account.balance.should == old_balance - payment.amount
    end
    it "should block balance update if allow_debit is false" do
      account.save
      payment.amount = account.balance + 200
      payment.direction = 'withdrawal'
      payment.should_not be_valid
      payment.save.should_not == true
    end
  end

end
