class CurrencyConversion < ActiveRecord::Base
  class MissingConversionError < StandardError ; end
  belongs_to :currency, foreign_key: :currency_code
  validates_presence_of :currency_code, :valid_from, :factor
  # Base currency is always conversion factor of 1
  # Non-base is what do we multiply by to get to base
  def convert from_code, amount
    if from_code == currency_code
      amount
    else
      if from_conv = self.class.find_current_converter(from_code)
        base_currency_amount = (amount * factor)/ from_conv.factor
      else
        raise MissingConversionError.new( I18n.translate('no_conversion_available',code:from_code))
      end
    end
  end
  def self.find_current_converter currency_code
    find_all_by_currency_code( currency_code, order: 'valid_from desc').first
  end
end
