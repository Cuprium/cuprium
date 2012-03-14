class DataManager::PaymentsController < DataManager::CommonController
  respond_to :html
  def new
    direction = params[:direction] || 'payment'
    @account = Account.find params[:account_number] 
    @payment = Payment.new(direction: direction, account: @account.number )
  end
  def create
    @payment = Payment.new params[:payment]
    @payment.save
    @account = Account.find @payment.account
    respond_with @payment
  end
end
