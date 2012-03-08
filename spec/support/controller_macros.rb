module ControllerMacros
  include Devise::TestHelpers

  def login_data_manager
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:data_manager]
      sign_in Factory.create(:data_manager) # Using factory girl as an example
    end
  end
end