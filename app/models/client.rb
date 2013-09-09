class Client < ActiveRecord::Base
  include AddressesHelper
  validates_presence_of :title_id, :first_name, :last_name, :address1, :town, :postcode, :email
  before_validation :normalise_postcode
  validates_with PostcodeValidator, attributes: [:postcode]
  validates_with EmailValidator, attributes: [:email]
  private
  def normalise_postcode
    self.postcode = normalise_postcode_helper(self.postcode)
  end
end
