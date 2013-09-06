require 'spec_helper'
#require 'addresses_helper'
class HelperProxy 
  include AddressesHelper
end
describe AddressesHelper do
  let(:helper) { HelperProxy.new }
  context "valid codes" do
    [ { from: 'ch991xx', to: 'CH99 1XX' },
      { from: 'l19qq', to: 'L1 9QQ' },
      { from: 'll19qq', to: 'LL1 9QQ' },
      { from: 'CH99 1XX', to: 'CH99 1XX' },
      { from: 'L1 9QQ', to: 'L1 9QQ' },
      { from: 'LL1 9QQ', to: 'LL1 9QQ' },
      { from: 'CH9 91XX', to: 'CH99 1XX' },
      { from: ' L19QQ', to: 'L1 9QQ' },
      { from: 'LL19 QQ', to: 'LL1 9QQ' },
      { from: 'CH 991 XX', to: 'CH99 1XX' },
    ].each do |example|
      it "convert #{example[:from]} to #{example[:to]}" do
        helper.normalise_postcode(example[:from]).should eq example[:to]
      end
    end
  end
  context "invalid codes" do
    [ { from: 'ch991xx1', to: 'CH991XX1' },
      { from: 'l1999qq', to: 'L1999QQ' },
      { from: 'll19 qqx', to: 'LL19 QQX' },
      { from: 'CH99 1XX', to: 'CH99 1XX' },
    ].each do |example|
      it "convert #{example[:from]} to #{example[:to]}" do
        helper.normalise_postcode(example[:from]).should eq example[:to]
      end
    end
  end
end
