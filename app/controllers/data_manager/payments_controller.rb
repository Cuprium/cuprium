class DataManager::PaymentsController < DataManager::CommonController
  def new
    direction = params[:direction] || 'in'
    @payment = Payment.new(direction: direction)
  end
  def create
    @payment = params[:payment]
  end
end
