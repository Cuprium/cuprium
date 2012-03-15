# This is a place holder class while we allow the objects to develop and grow
require 'pstore'
require 'account'
class Payment 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :amount, :account, :direction
  validates_presence_of :amount, :account, :direction
  validates_numericality_of :amount, greater_than: 0
  validates_inclusion_of :direction, in: %w(payment withdrawal), message: I18n.t(:payment_must_be_payment_or_withdrawal)
  validate :debit_account_allowed
  def initialize(values={})
    @amount, @account, @direction = values[:amount].to_f, values[:account], values[:direction]
  end
  def save
    if valid?
      cuprium_store.transaction do
        cuprium_store[:payments] ||= Array.new
        cuprium_store[:payments] << self
        accounts = cuprium_store[:accounts]
        account = accounts.find { |acc| acc.number == self.account }
        if account
          balance_adjustment = amount.to_f
          balance_adjustment = (balance_adjustment * -1.00) if direction == 'withdrawal'
          account.balance += balance_adjustment
          true
        else
          errors.add :account, "not found"
          cuprium_store.abort
          false
        end
      end
    end
  end
  def debit_account_allowed
    return true if direction == 'payment' 
    if acc = Account.find(self.account)
      if (acc.balance - amount) < acc.debit_limit
        errors.add(:amount,I18n.t(:debit_balance_not_allowed)) 
        false
      end
    else
      true
    end
  end
  def self.all
    cuprium_store.transaction(true) do
      cuprium_store[:payments]
    end
  end
  def persisted?
    false
  end
  # Pull cuprium_store into its own class later
  private
  def cuprium_store
    self.class.cuprium_store
  end
  def self.cuprium_store
    @cuprium_store ||= PStore.new("cuprium_store.pstore")
  end
end