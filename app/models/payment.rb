# This is a place holder class while we allow the objects to develop and grow
require 'pstore'
class Payment 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :amount, :account, :direction
  def initialize(values={})
    @amount, @account, @direction = values[:amount], values[:account], values[:direction]
  end
  def save
    ledger.transaction do
      ledger[:payments] ||= Array.new
      ledger[:payments] << self
    end
  end
  def self.all
    ledger.transaction(true) do
      ledger[:payments]
    end
  end
  def persisted?
    false
  end
  # Pull ledger into its own class later
  private
  def ledger
    self.class.ledger
  end
  def self.ledger
    @ledger ||= PStore.new("ledger.pstore")
  end
end