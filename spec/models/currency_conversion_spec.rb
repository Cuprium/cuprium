require 'spec_helper'

describe CurrencyConversion do
  let(:other_conversion)  { build :currency_conversion, valid_from: 2.days.ago}
  let(:conversion) { build :currency_conversion }
  let(:conversion_alt) { build :currency_conversion, currency_code: 'XX2', valid_from: Time.now, factor: 3 }
  let(:base_conversion) { CurrencyConversion.find_by_currency_code Lookup::BaseCurrency }
  let(:amount) { 10 }
  context "validation" do
    it { should belong_to :currency } 
    [ :currency_code, :valid_from, :factor, ].each  { |col| it { should validate_presence_of col  }}
  end
  context "calculate conversions" do
    before :all do 
      create :gbp unless Currency.find_by_code 'GBP'
      create :gbp_conversion unless CurrencyConversion.find_by_currency_code 'GBP'
    end
    it "should leave amount the same for same currency" do
      conversion.convert(conversion.currency_code,amount).should == amount
    end
    it "should calculate the amount correctly from the base currency" do
      conversion.convert(Lookup::BaseCurrency,amount).round(2).should == (amount * conversion.factor).round(2)
    end
    it "should calculate the amount correctly to the base currency" do
      conversion.save!
      base_conversion.convert(conversion.currency_code,amount).should == amount / conversion.factor
    end
    it "should calculate the amount correctly between non base currencies" do
      conversion_alt.save!
      conversion.convert(conversion_alt.currency_code,amount).round(2).should == ((amount / conversion_alt.factor) * conversion.factor).round(2)
    end
    it "should get the most recent conversion" do
      conversion.save!
      other_conversion.save!
      CurrencyConversion.find_current_converter(other_conversion.currency_code).should == conversion
    end
    it "should error out if the conversion can't be found" do
      lambda {
        conversion.convert('YYY',amount)
      }.should raise_error CurrencyConversion::MissingConversionError
    end
  end
end
