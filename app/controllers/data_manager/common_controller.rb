# This controller holds all the common methods and setup for the data manager
class DataManager::CommonController < ApplicationController
  layout 'data_manager'
  before_filter :authenticate_data_manager!
  def index
  end
end