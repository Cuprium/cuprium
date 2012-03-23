require 'spec_helper'

describe Ledger do

  let(:account) { create :account }
  let(:credit) { create :entry, direction: 1 }
  let(:ledger_credit) { build( :ledger, amount: 1, account: account.number, entry: credit ) }
  let(:debit) { create :entry, direction: -1, name:"debit" }
  let(:ledger_debit) { build( :ledger, amount: 1, account: account.number, entry: debit ) }

  context "valdation" do
    [:amount, :account, :entry].each do |col|
      it { should validate_presence_of col }
    end
    it "amount greater than 0" do
      ledger_credit.amount = 0.00
      ledger_credit.should_not be_valid
    end
  end

  context "account balance" do
    it "should increase balance for ledger" do
      old_balance = account.balance
      ledger_credit.save
      changed_account = Account.find account.number
      changed_account.balance.should == old_balance + ledger_credit.amount
    end
    it "should decrease balance for withdrawal" do
      account.save
      old_balance = account.balance
      ledger_debit.save
      changed_account = Account.find account.number
      changed_account.balance.should == old_balance - ledger_debit.amount
    end
    it "should block balance update if allow_debit is false" do
      account.save
      ledger_debit.amount = account.balance + 200
      ledger_debit.should_not be_valid
      ledger_debit.save.should_not == true
    end
  end

end
