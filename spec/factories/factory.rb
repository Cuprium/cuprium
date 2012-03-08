FactoryGirl.define do 
  factory :data_manager do |data_manager|
    data_manager.email        "example@cuprium.org"
    data_manager.password          "example1234"
    data_manager.password_confirmation          "example1234"
    data_manager.first_name 'Test'
    data_manager.last_name 'Test'
    data_manager.title_id 1
  end
end