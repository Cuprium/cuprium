FactoryGirl.define do 
  factory :withdrawal do |withdrawal|
    withdrawal.amount 0.00
    withdrawal.account "test-acc-1"
  end
end
