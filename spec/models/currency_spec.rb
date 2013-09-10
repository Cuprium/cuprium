require 'spec_helper'

describe Currency do
  [:code,:name,:decimal_places,:iso_number].each { |col| it { should validate_presence_of col }}
  it { should have_many(:accounts) }
  it { should have_many(:currency_conversions) }

  before :each do
    create(:gbp) unless Currency.find_by_code 'GBP'
    create(:eur) unless Currency.find_by_code 'EUR'
  end

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
      Currency['EUR'].code.should == 'EUR'
    end
    it "defaults to GBP" do
      Currency['XXX'].code.should == 'GBP'
    end
  end
  context "currency_codes" do
    it "contains GBP" do
      Currency.currency_codes.should include('GBP')
    end
  end
end
