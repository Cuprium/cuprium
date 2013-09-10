FactoryGirl.define do 
  factory :account do |account|
    account.number "test-acc-1"
    account.owner "test-owner-1"
    account.type "share"
    account.balance 500
    account.currency_code Lookup::BaseCurrency 
  end
end
