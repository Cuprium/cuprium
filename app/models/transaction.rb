require 'payment'
require 'withdrawal'
require 'cuprium_store'
# super class of all transaction-style operations
# these will call the transact method with a block specific to their needs
class Transaction 
  include ActiveModel::Validations
  include ActiveModel::Callbacks
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  include CupriumStore

  attr_accessor :number, :activity
  validates_presence_of :number, :activity

  # Uncomment when we refactor away from pstore
  # before_create :generate_number

  def initialize(values={})
    @number, @activity = values[:number], values[:activity]
  end

  # for an example block see the Transfer class
  def transact &transact_activity
    cuprium_store.transaction do
      cuprium_store[:transactions] ||= Array.new
      self.number = cuprium_store[:transactions].length + 1
      puts "bif"
      yield self, cuprium_store
      puts "baf"
      if valid?
        puts "bef"
        cuprium_store[:transactions] << self
        true
      else
        puts "buf"
        cuprium_store.abort
        false
      end
    end
  end
  def self.all
    cuprium_store.transaction(true) do
      cuprium_store[:transactions]
    end
  end
  def self.find number_to_find=nil
    cuprium_store.transaction(true) do
      cuprium_store[:transactions].find { |trans| trans.number == number_to_find } if cuprium_store[:transactions]
    end
  end
  def self.filter_by activity
    if activity.present?
      filter = Regexp.new activity
      cuprium_store.transaction(true) do
        cuprium_store[:transactions].select { |trans| trans.activity =~ filter } if cuprium_store[:transactions]
      end
    else
      []
    end
  end
  def id
    number
  end
  # place holder for the before create - may not live when we move from pstore
  # def generate_number
  #   # Get the next in the sequence - or we'll just use the ID?
  # end
  def persisted?
    false
  end
  def == other
    number == other.number
  end
end