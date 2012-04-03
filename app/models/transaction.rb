# super class of all transaction-style operations
# these will call the transact method with a block specific to their needs
class Transaction < ActiveRecord::Base

  validates_presence_of :activity, :from_conversion_id, :to_conversion_id
  attr_accessible :activity, :from_conversion_id, :to_conversion_id
  belongs_to :from_conversion, class_name: 'CurrencyConversion', foreign_key: :from_conversion_id
  belongs_to :to_conversion, class_name: 'CurrencyConversion', foreign_key: :to_conversion_id
end