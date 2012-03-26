# This is a place holder class while we allow the objects to develop and grow
# This is the superclass of all ledger-related activity
# The child classes have an entry type that determines the direction of the money flow
require 'cuprium_store'
class Ledger 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include CupriumStore

  class NoEntry < StandardError 
    def initialize(*args)
      super I18n.translate(:cannot_create_a_ledger_entry_without_a_type)
    end
  end

  attr_accessor :amount, :account, :entry, :transaction

  validates_presence_of :amount, :account, :entry
  validates_numericality_of :amount, greater_than: 0

  validate :debit_account_allowed
  def initialize(values={})
    @amount, @account, @entry = values[:amount].to_f, values[:account], values[:entry]
    self
  end
  def name
    entry.name
  end
  def name= dummy
    # Do nothing because the entry name is fixed, but we want forms to render
  end

  # TODO !Important! ban updates 

  def self.entry
    Entry.find self.to_s.underscore
  end

  def save
    self.entry = self.class.entry
    raise NoEntry if entry.blank?
    if valid?
      cuprium_store.transaction do
        cuprium_store[:payments] ||= Array.new
        cuprium_store[:payments] << self
        accounts = cuprium_store[:accounts]
        account = accounts.find { |acc| acc.number == self.account }
        if account
          balance_adjustment = amount.to_f
          balance_adjustment = (balance_adjustment * entry.direction)
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
    return true if entry && entry.direction == 1
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
      cuprium_store[:ledger_entries]
    end
  end
  def persisted?
    false
  end
end