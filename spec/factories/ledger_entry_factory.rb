FactoryGirl.define do 
  factory :ledger_entry do |ledger_entry|
    ledger_entry.amount 0.00
    ledger_entry.account "test-acc-1"
    ledger_entry.after_build do |thing|
      ledger_entry.entry Factory.build(:entry)
    end
  end
end
