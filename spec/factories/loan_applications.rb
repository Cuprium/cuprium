# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :loan_application do
    state "MyString"
    client_id 1
    loan_product_id 1
    client_details "MyText"
  end
end
