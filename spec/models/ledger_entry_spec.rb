require 'spec_helper'

describe LedgerEntry do

  # We're testing payments and withdrawals here because you can't save a ledger
  # entry without a type
  let(:account) { create :account }
  let(:ledger_credit) { build( :payment, amount: 1, account: account ) }
  let(:ledger_debit) { build( :withdrawal, amount: 1, account: account ) }

  context "valdation" do
    [:amount, :account_id].each do |col|
      it "should validate_presence_of #{col}" do
         ledger_credit.should be_valid
         ledger_credit[col] = nil
         ledger_credit.should_not be_valid
       end
    end
    it "amount greater than 0" do
      ledger_credit.amount = 0.00
      ledger_credit.should_not be_valid
    end
    it "won't allow save without an entry type" do
      lambda { 
        Ledger.new.save
      }.should raise_exception Ledger::NoEntry
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
