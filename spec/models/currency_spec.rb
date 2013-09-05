require 'spec_helper'

describe Currency do
  context "display_currency" do
    it "GBP" do
      amount = 10000 
      currency_code = 'GBP'
      Currency.display_currency(currency_code,amount).should == "&pound;10,000.00"
    end
    it "EUR" do
      amount = 10000 
      currency_code = 'EUR'
      Currency.display_currency(currency_code,amount).should == "&euro;10,000.00"
    end
    it "GBP negative" do
      amount = -10000 
      currency_code = 'GBP'
      Currency.display_currency(currency_code,amount).should == "-&pound;10,000.00"
    end
  end
  context "finds currencies" do
    it "finds EUR" do
      Currency['EUR'].currency_code.should == 'EUR'
    end
    it "defaults to GBP" do
      Currency['XXX'].currency_code.should == 'GBP'
    end
  end
  context "currency_codes" do
    it "contains GBP" do
      Currency.currency_codes.should include('GBP')
    end
  end
end
