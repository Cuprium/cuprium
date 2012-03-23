class DataManager::PaymentsController < DataManager::CommonController
  respond_to :html
  before_filter :setup_base_class, except: :index
  def new
    @account = Account.find params[:account_number] 
    @payment = @base_class.new(account: @account.number )
  end
  def create
    @payment = @base_class.new params[:payment]
    @payment.save
    @account = Account.find @payment.account
  end
  private
  def setup_base_class
    @base_class = params[:payment][:name].titleize.constantize
  end
end
