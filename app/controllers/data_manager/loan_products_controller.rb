class DataManager::LoanProductsController < DataManager::CommonController
  respond_to :html
  def index
    @loan_products = LoanProduct.all
  end
  def new
    @loan_product = LoanProduct.new
  end
  def create
    @loan_product = LoanProduct.create(params[:loan_product])
    respond_with(:data_manager,@loan_product,location: data_manager_loan_products_url)
  end
  def show
    @loan_product = LoanProduct.find params[:id]
  end
end
