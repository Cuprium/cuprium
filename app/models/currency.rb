class Currency < ActiveRecord::Base
  self.primary_key = :code
  validates_presence_of :code,:name,:decimal_places,:iso_number
  has_many :accounts, foreign_key: :currency_code
  attr_accessible :code,:name,:decimal_places,:iso_number
end