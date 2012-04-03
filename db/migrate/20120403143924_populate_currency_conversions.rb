class PopulateCurrencyConversions < ActiveRecord::Migration
  def up
    CurrencyConversion.create do |currency_conversion|
      currency_conversion.currency_code  = Lookup::BaseCurrency
      currency_conversion.valid_from = Date.today
      currency_conversion.factor = 1
    end
  end

  def down
  end
end
