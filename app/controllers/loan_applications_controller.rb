class LoanApplicationsController < ApplicationController
  respond_to :html
  before_filter :find_loan_product, except: [:index,:page]

  def index
    @loan_products = LoanProduct.all
  end
  
  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
    if @client.valid?
      @loan_application = @loan_product.loan_applications.new
      @loan_application.raw_client = @client
      @loan_application.save!
      redirect_to page_loan_application_path(@loan_application,page_number:0)
    else
      render :new
    end
  end

  def page
    @loan_application = LoanApplication.find params[:id]
    @pages = @loan_application.pages
    # Note using Integer not to_i so lack of param will cause
    # an exception
    @page_number = Integer(params[:page_number])
    @page = @pages[@page_number]
  end
  def save_page
    
  end
  private
  def find_loan_product
    @loan_product = LoanProduct.find params[:product_id]
  end
end
