class DataManager::PaymentsController < DataManager::CommonController
  respond_to :html
  def new
    @account = Account.find params[:account_number] 
    @payment = ledger_class.new(account: @account.number )
  end
  def create
    @payment = ledger_class.new params[:payment]
    @payment.save
    @account = Account.find @payment.account
  end
  private
  def ledger_class
    @ledger_class ||= (params[:name] || params[:payment][:name]).titleize.constantize
  end
end
