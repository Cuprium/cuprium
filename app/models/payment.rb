# This is a place holder class while we allow the objects to develop and grow
require 'pstore'
require 'account'
require 'entry'
require 'ledger'
class Payment < Ledger
  def self.entry
    Entry.find 'payment'
  end
  def initialize(params={})
    super
    self.entry = self.class.entry
  end
end