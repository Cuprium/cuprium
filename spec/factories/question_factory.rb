# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    loan_product_id 1
    page 1
    display_order 1
    kind 'yesno'
    text "MyString"
  end
end
