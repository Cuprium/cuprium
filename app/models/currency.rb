# For now keeping this class out of the database until we know its 
# shape properly
Currency = Struct.new(:currency_code, :html_code, :delimiter, :precision) do
  GBP = new 'GBP', '&pound;', ',', 2
  EUR = new 'EUR', '&euro;', ',', 2
  USD = new 'USD', '$', ',', 2
  def self.currencies
    @currencies ||= { 'GBP' => GBP, 'EUR' => EUR, 'USD' => USD }
  end
  def self.[] currency_code
    currencies[currency_code] || GBP
  end
  def self.currency_codes
    currencies.keys
  end
  def self.display_currency currency_code, amount
    self[currency_code].display_currency amount
  end
  def display_currency amount
    amount = BigDecimal.new amount
    number_parts = amount.abs.to_s.split /\./
    number_parts[0] = number_parts[0].reverse.gsub(/(\d{3})(?=\d)/, '\\1' + delimiter ).reverse
    trailing_zeros = precision - number_parts[1].length 
    number_parts[1] += '0' * trailing_zeros if trailing_zeros > 0
    number = number_parts.join('.')
    sign = ""
    sign = "-" if amount < 0
    "#{sign}#{html_code}#{number}"
  end

end
