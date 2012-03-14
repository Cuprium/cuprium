# This is a place holder class while we allow the objects to develop and grow
require 'pstore'
class Account 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :number, :owner, :type, :search
  attr_accessor :balance
  def initialize(values={})
    @number, @owner, @type = values[:number], values[:owner], values[:type]
    @search = ""
    @balance = 0.00
  end
  def save
    cuprium_store.transaction do
      cuprium_store[:accounts] ||= Array.new
      cuprium_store[:accounts].delete_if { |acc| acc.number == self.number }
      cuprium_store[:accounts] << self
    end
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
  # Pull cuprium_store into its own class later
  private
  def cuprium_store
    self.class.cuprium_store
  end
  def self.cuprium_store
    @cuprium_store ||= PStore.new("cuprium_store.pstore")
  end
end