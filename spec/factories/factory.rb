FactoryGirl.define do 
  factory :data_manager do |data_manager|
    # The seeded emaul is example@ - so we use something different
    data_manager.email        "example.main@cuprium.org"
    data_manager.password          "example1234"
    data_manager.password_confirmation          "example1234"
    data_manager.first_name 'Test'
    data_manager.last_name 'Test'
    data_manager.title_id 1
  end
  factory :account do |account|
    account.number "test-acc-1"
    account.owner "test-ownder-1"
    account.type "share"
    account.balance 500
  end
  factory :payment do |payment|
    payment.amount 0.00
    payment.account "test-acc-1"
  end
  factory :withdrawal do |withdrawal|
    withdrawal.amount 0.00
    withdrawal.account "test-acc-1"
  end
  factory :ledger do |ledger|
    ledger.amount 0.00
    ledger.account "test-acc-1"
    ledger.after_build do |thing|
      ledger.entry Factory.build(:entry)
    end
  end
  factory :entry do |entry|
    entry.direction 1
    entry.name "payment"
  end
end