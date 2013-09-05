def test_password
  "testPassword123"
end
def create_data_manager
  @data_manager ||= create(:data_manager, password: test_password)
end
def sign_in data_manager
  visit new_data_manager_session_path
  fill_in "Email", with: data_manager[:email]
  fill_in "Password", with: test_password
  click_button "Sign in"
  @logged_in_data_manager = data_manager
end


Given(/^I am logged in as a Data Manager$/) do
  sign_in create_data_manager
end

When(/^I click "(.*?)"$/) do |link|
  click_link link
end

When(/^I press "(.*?)"$/) do |button|
  click_button button
end

Given(/^I click the first account$/) do
  within("#account-index") do
    click_link find('a').text
  end
end

When(/^I search for "(.*?)"$/) do |account_number|
  fill_in "search", with: account_number
  click_button "Search for Account"
end

Then(/^I should see account "(.*?)"$/) do |account_number|
  body.should match(Regexp.new(account_number))
end

Given(/^I enter (\d+\.\d\d) in ([^ ]+) amount$/) do |amount, type|
  fill_in "#{type}_amount", with: amount
end

Then(/^I should see "(.*?)"$/) do |thing|
  body.match Regexp.new(thing)
end
