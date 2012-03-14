# This is a place holder class while we allow the objects to develop and grow
require 'pstore'
require 'account'
class Payment 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :amount, :account, :direction
  def initialize(values={})
    @amount, @account, @direction = values[:amount].to_f, values[:account], values[:direction]
  end
  def save
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