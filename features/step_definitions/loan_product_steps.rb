def find_or_create_loan_product_named name
  @loan_product = LoanProduct.find_by_name(name) || create(:loan_product,name:name)
end

Given(/^I start from the home screen$/) do
  visit root_path
end

When(/^I fill in the product name with "(.*?)"$/) do |name|
  fill_in "loan_product_name", with: name
end

Given(/^loan product called "(.*?)" exists$/) do |name|
  find_or_create_loan_product_named name
end

When(/^I fill in the question details$/) do
  select '1', from: 'question_page'
  select '1', from: 'question_display_order'
  select 'Yes/No', from: 'question_kind'
  fill_in "question_text", with: "Some test question text"
end

When(/^I update the question text to "(.*?)"/) do |new_text|
  select '2', from: 'question_page'
  select '2', from: 'question_display_order'
  fill_in "question_text", with: new_text
end

Given(/^loan product "(.*?)" has question "(.*?)"$/) do |product_name, question_text|
  loan_product = find_or_create_loan_product_named product_name
  loan_product.questions.create!(text:question_text,page:1,display_order:1)
end

