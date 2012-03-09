require 'spec_helper'

describe DataManager::HomeController do

  describe "GET 'index'" do
    login_data_manager
    it "returns http success if logged in" do
      get 'index'
      response.should be_success
    end
    it "does not give http success if not logged in" do
      sign_out :data_manager
      get 'index'
      response.should_not be_success
    end
    it "has the data_manager layout" do
      get 'index'
      response.should render_template("data_manager")
    end
    context "rendering" do
      render_views
      it "defaults the locale" do
        get 'index'
        response.body.should_not =~ /TEST Free and Open Source/m
      end
      it "respects the locale" do
        get 'index', locale: 'test'
        response.body.should =~ /TEST Free and Open Source/m
      end
    end
  end

end
