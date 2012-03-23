# This is a place holder class while we allow the objects to develop and grow
require 'pstore'
require 'payment'
require 'withdrawal'
class Account 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :number, :owner, :type, :search, :balance, :debit_limit
  validates_presence_of :number, :owner, :type, :balance

  def initialize(values={})
    @number, @owner, @type, @debit_limit = values[:number], values[:owner], values[:type], values[:debit_limit]
    @balance = 0.00
    @debit_limit = 0.00 if @debit_limit.blank?
    @search = ""
  end
  def save!
    save
  end
  def save
    if valid?
      cuprium_store.transaction do
        cuprium_store[:accounts] ||= Array.new
        cuprium_store[:accounts].delete_if { |acc| acc.number == self.number }
        cuprium_store[:accounts] << self
      end
    end
    true
  end
  def self.all
    cuprium_store.transaction(true) do
      cuprium_store[:accounts]
    end
  end
  def self.find number_to_find=nil
    cuprium_store.transaction(true) do
      cuprium_store[:accounts].find { |acc| acc.number == number_to_find } if cuprium_store[:accounts]
    end
  end
  def self.filter_by number_or_owner
    if number_or_owner.present?
      filter = Regexp.new number_or_owner
      cuprium_store.transaction(true) do
        cuprium_store[:accounts].select { |acc| acc.number =~ filter || acc.owner =~ filter } if cuprium_store[:accounts]
      end
    else
      []
    end
  end
  def id
    number
  end
  def persisted?
    false
  end
  def == other
    number == other.number
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