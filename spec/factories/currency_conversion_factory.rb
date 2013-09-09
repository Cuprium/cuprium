FactoryGirl.define do 
  factory :currency_conversion do |currency_conversion|
    currency_conversion.currency_code "XXX"
    currency_conversion.valid_from Date.today
    currency_conversion.factor 1.5
  end
end
