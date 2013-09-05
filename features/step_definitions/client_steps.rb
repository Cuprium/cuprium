When(/^I fill in the client information$/) do
  select 'Mr', from: 'client_title_id'
  fill_in "client_first_name", with: "First"
  fill_in "client_last_name", with: "Last"
  fill_in "client_address1", with: "1, Test Street"
  fill_in "client_address2", with: "Address 2"
  fill_in "client_address3", with: "Address 3"
  fill_in "client_town", with: "Test Town"
  fill_in "client_postcode", with: "xx99 9yy"
  fill_in "client_email", with: "test.client@cuprium.com"
end

Then(/^I should see the client information$/) do
  body.should match(Regexp.new( "Mr" ))
  body.should match(Regexp.new( "First" ))
  body.should match(Regexp.new( "Last" ))
  body.should match(Regexp.new( "1, Test Street" ))
  body.should match(Regexp.new( "Address 2" ))
  body.should match(Regexp.new( "Address 3" ))
  body.should match(Regexp.new( "Test Town" ))
  body.should match(Regexp.new( "xx99 9yy" ))
  body.should match(Regexp.new( "test.client@cuprium.com" ))
end
