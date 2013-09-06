require 'spec_helper'
class Validatable
  include ActiveModel::Validations
  attr_accessor :postcode
  validates_with PostcodeValidator, attributes: [:postcode]
end
describe PostcodeValidator do
  let(:validator) { Validatable.new }
  context "Valid postcodes" do
    [
      'CH99 1XX',
      'L1 9QQ',
      'LL1 9QQ',
    ].each do |code|
      it "should accept #{code}" do
        validator.postcode = code
        validator.should be_valid
      end
    end
  end
  context "Invalid postcodes" do
    [
      'ch99 1xx',
      'l1 9qq',
      'll1 9qq',
      'ch991xx1', 
      'CH991XX1',
      'l1999qq',
      'L1999QQ',
      'll19 qqx',
      'll19 1qqx',
      'LL19 QQX',
    ].each do |code|
      it "should not accept #{code}" do
        validator.postcode = code
        validator.should_not be_valid
      end
    end
  end
end
