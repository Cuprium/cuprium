require 'spec_helper'

describe DataManager::AccountsController do

  describe "GET 'search'" do
    login_data_manager
    it "returns http success" do
      get 'search'
      response.should be_success
    end
  end

end
