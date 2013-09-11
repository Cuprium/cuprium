class LoanApplicationsController < ApplicationController
  def new
    @client = session[:client] || Client.new
  end

  def create
  end
end
