FactoryGirl.define do 
  factory :currency do |currency|
    currency.code "XXX"
    currency.name "Test"
    currency.decimal_places 2
    currency.iso_number "0101"
  end
end
