class PopulateDefaultCurrencyHtmlCodes < ActiveRecord::Migration
  def up
    (val = Currency.find_by_code('GBP')) ? val.update_attribute(:html_code,'&pound;') : nil
    (val = Currency.find_by_code('EUR'))? val.update_attribute(:html_code,'&euro;') : nil
    (val = Currency.find_by_code('USD'))? val.update_attribute(:html_code,'$') : nil
  end

  def down
  end
end
