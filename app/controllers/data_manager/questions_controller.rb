class DataManager::QuestionsController < DataManager::CommonController
  respond_to :html
  before_filter :setup_loan_product

  def new
    @question = @loan_product.questions.new
  end

  def create
    if @question = @loan_product.questions.create(params[:question])
      flash[:message] =  t(:created_ok,name: Question.model_name) 
      redirect_to data_manager_loan_product_path(@loan_product)
    else
      respond_with @question
    end
  end

  def edit
    @question = @loan_product.questions.find params[:id]
  end

  def update
    @question = @loan_product.questions.find params[:id]
    if @question.update_attributes(params[:question])
      flash[:message] =  t(:updated_ok,name: Question.model_name) 
      redirect_to data_manager_loan_product_path(@loan_product)
    else
      respond_with @question
    end
  end

  def destroy
  end

  private
  def setup_loan_product
    @loan_product = LoanProduct.find params[:loan_product_id]
  end

end
