def dummy_client
  @dummy_client ||= Client.new do |client|
    client.title_id      = 1
    client.first_name    = "First"
    client.last_name     = "Last"
    client.date_of_birth = "01/01/1970"
    client.address1      = "1, Test Street"
    client.address2      = "Address 2"
    client.address3      = "Address 3"
    client.town          = "Test Town"
    client.postcode      = "xx99 9yy"
    client.email         = "test.client@cuprium.org"
    client.phone         = "0774567890"
    client.alt_phone     = "0774567891"
  end
end

def amended_client
  @amended_client ||= Client.new do |client|
    client.title_id      = 2
    client.first_name    = "First amended"
    client.last_name     = "Last amended"
    client.date_of_birth = "02/01/1970"
    client.address1      = "2, Test Street"
    client.address2      = "Address 2 amended"
    client.address3      = "Address 3 amended"
    client.town          = "Test Town amended"
    client.postcode      = "xx98 9yy"
    client.email         = "test.client2@cuprium.org"
    client.phone         = "0774567892"
    client.alt_phone     = "0774567893"
  end
end

When(/^I fill in my details$/) do
  select 'Mr', from: 'client_title_id'
  fill_in "client_first_name",    with: dummy_client.first_name
  fill_in "client_last_name",     with: dummy_client.last_name
  fill_in "client_date_of_birth", with: dummy_client.date_of_birth
  fill_in "client_address1",      with: dummy_client.address1
  fill_in "client_address2",      with: dummy_client.address2
  fill_in "client_address3",      with: dummy_client.address3
  fill_in "client_town",          with: dummy_client.town
  fill_in "client_postcode",      with: dummy_client.postcode
  fill_in "client_email",         with: dummy_client.email
  fill_in "client_phone",         with: dummy_client.phone
  fill_in "client_alt_phone",     with: dummy_client.alt_phone
end

#This code was written at the wrong time but kept to avoid
#redoing it
#When(/^I update the client details$/) do
#  select 'Ms', from: 'client_title_id'
#  fill_in "client_first_name",    with: amended_client.first_name
#  fill_in "client_last_name",     with: amended_client.last_name
#  fill_in "client_date_of_birth", with: amended_client.date_of_birth
#  fill_in "client_address1",      with: amended_client.address1
#  fill_in "client_address2",      with: amended_client.address2
#  fill_in "client_address3",      with: amended_client.address3
#  fill_in "client_town",          with: amended_client.town
#  fill_in "client_postcode",      with: amended_client.postcode
#  fill_in "client_email",         with: amended_client.email
#  fill_in "client_phone",         with: amended_client.phone
#  fill_in "client_alt_phone",     with: amended_client.alt_phone
#end

