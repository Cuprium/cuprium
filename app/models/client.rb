class Client < ActiveRecord::Base
  validates_presence_of :title_id, :first_name, :last_name, :address1, :town, :postcode, :email
end
