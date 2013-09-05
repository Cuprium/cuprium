class DataManager::PaymentsController < DataManager::CommonController
  respond_to :html
  def new
    @account = Account.find params[:account_number] 
    @payment = ledger_class.new(account: @account )
  end
  def create
    @payment = ledger_class.new trans_type
    @payment.save
    @account = Account.find @payment.account
    respond_with @payment
  end
  private
  def ledger_class
    # The name is the name of the transaction type, e.g. Payment or Withdrawal etc.
    @ledger_class ||= (params[:name] || trans_type[:name]).titleize.constantize
  end
  def trans_type
    @trans_type ||= params[:payment] || params[:withdrawal]
  end
end
