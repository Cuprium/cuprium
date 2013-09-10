FactoryGirl.define do 
  factory :currency_conversion do 
    currency_code "XXX"
    valid_from Date.today
    factor 1.5
    factory :gbp_conversion do
      currency_code "GBP"
      valid_from Date.today
      factor 1
    end
  end
end
