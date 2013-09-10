FactoryGirl.define do 
  factory :currency do
    code "XXX"
    name "Test"
    decimal_places 2
    iso_number "0101"
    factory :gbp do 
      code "GBP"
      name "Pound Sterling"
      decimal_places 2
      iso_number "826"
      html_code "&pound;"
    end
    factory :eur do 
      code "EUR"
      name "Euro"
      decimal_places 2
      iso_number "978"
      html_code "&euro;"
    end
    factory :usd do 
      code "USD"
      name "United States dollar"
      decimal_places 2
      iso_number "840"
      html_code "$"
    end
  end
end
