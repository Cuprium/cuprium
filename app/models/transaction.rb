# super class of all transaction-style operations
# these will call the transact method with a block specific to their needs
class Transaction < ActiveRecord::Base

  validates_presence_of :activity
  attr_accessible :activity

  # for an example block see the Transfer class
  def transact &transact_activity
    transaction do
      yield self
      save
    end
  end
end