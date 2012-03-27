# This is the superclass of all ledger-related activity
# The child classes have an entry type that determines the direction of the money flow
class LedgerEntry < ActiveRecord::Base

  validates_presence_of :amount, :account, :entry_id
  validates_numericality_of :amount, greater_than: 0

  validate :debit_account_allowed

  attr_accessible  :amount, :account, :entry_id

  belongs_to :account
  belongs_to :entry
  
  before_validation(:on => :create) do
    self.entry = Entry.find self.class.name.underscore
  end

  before_save(:on => :create) do
    balance_adjustment = (self.amount * entry.direction)
    account.balance += balance_adjustment
    account.save!
  end

  def name
    entry.name
  end
  def name= dummy
    # Do nothing because the entry name is fixed, but we want forms to render
  end
  def debit_account_allowed
    return true if entry && entry.direction == 1
    if acc = self.account
      if (acc.balance - amount) < acc.debit_limit
        errors.add(:amount,I18n.t(:debit_balance_not_allowed)) 
        false
      end
    else
      true
    end
  end
end