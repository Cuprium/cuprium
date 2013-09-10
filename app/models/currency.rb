# For now keeping this class out of the database until we know its 
# shape properly
class Currency < ActiveRecord::Base
  self.primary_key = :code
  validates_presence_of :code,:name,:decimal_places,:iso_number
  has_many :accounts, foreign_key: :currency_code
  has_many :currency_conversions, foreign_key: :currency_code 
  attr_accessible :code,:name,:decimal_places,:iso_number,:html_code

  def self.currencies
    all
  end
  def self.[] currency_code
    find_by_code(currency_code) || find_by_code(Lookup::BaseCurrency) 
  end
  def self.currency_codes
    currency_codes ||= currencies.collect(&:code)
  end
  def self.display_currency currency_code, amount
    self[currency_code].display_currency amount
  end
  def display_currency amount
    amount = BigDecimal.new amount
    number_parts = amount.abs.to_s.split /\./
    number_parts[0] = number_parts[0].reverse.gsub(/(\d{3})(?=\d)/, '\\1' + delimiter ).reverse
    trailing_zeros = decimal_places - number_parts[1].length 
    number_parts[1] += '0' * trailing_zeros if trailing_zeros > 0
    number = number_parts.join('.')
    sign = ""
    sign = "-" if amount < 0
    "#{sign}#{html_code}#{number}"
  end

  private
  #TODO move this into the table if it's ever needed
  def delimiter
    ','
  end

end
