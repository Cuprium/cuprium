class DataManager::HomeController < ApplicationController
  layout 'data_manager'
  before_filter :authenticate_data_manager!
  def index
  end
end
