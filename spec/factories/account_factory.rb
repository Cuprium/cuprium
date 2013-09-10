FactoryGirl.define do 
  factory :account do
    number "test-acc-1"
    owner "test-owner-1"
    type "share"
    balance 500
    currency_code Lookup::BaseCurrency 
    client_id 1
  end
end
