FactoryGirl.define do 
  factory :payment do |payment|
    payment.amount 0.00
    payment.account "test-acc-1"
  end
end
