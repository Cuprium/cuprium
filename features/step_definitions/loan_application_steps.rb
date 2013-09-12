Given(/^I start from the home screen$/) do
  visit root_path
end

When(/^I fill in my details$/) do
  select 'Mr', from: 'client_title_id'
  fill_in "client_first_name", with: "First"
  fill_in "client_last_name", with: "Last"
  fill_in "client_date_of_birth", with: "01/01/1970"
  fill_in "client_address1", with: "1, Test Street"
  fill_in "client_address2", with: "Address 2"
  fill_in "client_address3", with: "Address 3"
  fill_in "client_town", with: "Test Town"
  fill_in "client_postcode", with: "xx99 9yy"
  fill_in "client_email", with: "test.client@cuprium.org"
  fill_in "client_phone", with: "0774567890"
  fill_in "client_alt_phone", with: "0774567891"
end

When(/^I fill in the type name with "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
