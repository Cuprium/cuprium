FactoryGirl.define do 
  factory :data_manager do |data_manager|
    data_manager.email        "example@cuprium.org"
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
    payment.direction "payment"
    payment.account "test-acc-1"
  end
end