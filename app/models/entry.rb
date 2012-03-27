# This is a place holder class while we allow the objects to develop and grow
require 'payment'
class Entry < ActiveRecord::Base

  self.primary_key = :name

  validates_presence_of :direction, :name
  validates_inclusion_of :direction, in: [-1,1], message: I18n.t(:payment_must_be_credit_or_debit)
  attr_accessible  :direction, :name

  before_create :default_direction

  def default_direction
    self.direction = 1 if self.direction.blank?
  end
  def id
    name
  end
end