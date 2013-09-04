FactoryGirl.define do 
  factory :account do |account|
    account.number "test-acc-1"
    account.owner "test-ownder-1"
    account.type "share"
    account.balance 500
  end
end
