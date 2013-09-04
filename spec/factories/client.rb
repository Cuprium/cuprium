FactoryGirl.define do 
  factory :client do |client|
    client.title_id 1
    client.first_name "Test"
    client.last_name "Test"
    client.address1 "Test"
    client.address2 "Test"
    client.address3 "Test"
    client.town "Test"
    client.postcode "Test"
  end
end
