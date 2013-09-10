# This is a place holder class while we allow the objects to develop and grow
class Account < ActiveRecord::Base

  self.primary_key = :number
  self.inheritance_column = nil

  attr_accessor :search

  validates_presence_of :number, :owner, :type, :balance, :currency_code

  attr_accessible :number, :owner, :type, :balance, :debit_limit, :search, :currency_code

  belongs_to :currency, foreign_key: :currency_code
  belongs_to :client

  before_create :default_values
  
  has_many :ledger_entries

  def default_values
    self.balance ||= 0.00
    self.debit_limit ||= 0.00
    self.currency_code ||= Lookup::BaseCurrency
    self.search = ""
  end

  def current_conversion
    CurrencyConversion.find_current_converter currency_code
  end

  # TODO: This needs to be rewritten to use scopes properly
  def self.filter_by number_or_owner
    if number_or_owner.present?
      filter = Regexp.new number_or_owner
      all.select { |acc| acc.number =~ filter || acc.owner =~ filter }
    else
      []
    end
  end

  def id
    number
  end

  def display_balance
    Currency.display_currency currency_code, balance
  end
end
