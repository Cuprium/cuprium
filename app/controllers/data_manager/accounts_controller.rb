class DataManager::AccountsController < DataManager::CommonController
  def search
    @account = Account.new(search:params[:search])
    @on_select = params[:on_select]
    @accounts = Account.filter_by params[:search] 
  end
  def select
    unless redirect_to_derived_path(params[:id],params[:on_select])
      render action: 'search'
    end
  end
  private
  def redirect_to_derived_path id, on_select
    return false unless id.present? && on_select.present?
    case on_select
    when 'Payment', 'Withdrawal'
      redirect_to new_data_manager_payment_path(name:on_select,account_number:id)
    end
    true
  end
end
