# This is a place holder class while we allow the objects to develop and grow
require 'pstore'
require 'account'
require 'entry'
require 'ledger'
class Withdrawal < Ledger
  def self.entry
    Entry.find 'withdrawal'
  end
  def initialize(params={})
    super
    self.entry = self.class.entry
  end
end