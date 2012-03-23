# This is a place holder class while we allow the objects to develop and grow
require 'pstore'
require 'payment'
class Entry

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :direction, :name
  validates_presence_of :direction, :name
  validates_inclusion_of :direction, in: [-1,1], message: I18n.t(:payment_must_be_credit_or_debit)

  def initialize(values={})
    @direction, @name  = values[:direction], values[:name]
    @direction = 1 if @direction.blank?
  end
  def save!
    save
  end
  def save
    if valid?
      cuprium_store.transaction do
        cuprium_store[:entries] ||= Array.new
        cuprium_store[:entries].delete_if { |entry| entry.name == self.name }
        cuprium_store[:entries] << self
      end
    end
    true
  end
  def self.all
    cuprium_store.transaction(true) do
      cuprium_store[:entries]
    end
  end
  def self.find name_to_find=nil
    cuprium_store.transaction(true) do
      cuprium_store[:entries].find { |entry| entry.name == name_to_find } if cuprium_store[:entries]
    end
  end
  def id
    name
  end
  def persisted?
    false
  end
  def == other
    name == other.name
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