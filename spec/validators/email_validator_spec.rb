require 'spec_helper'
class Validatable
  include ActiveModel::Validations
  attr_accessor :email
  validates_with EmailValidator, attributes: [:email]
end
describe EmailValidator do
  let(:validator) { Validatable.new }
  context "Valid emails" do
    [
      'test@test.com',
      'test.test@test.com',
      'test-test@test.com',
      'test-test@test.org',
      'test-test@test.co.uk',
    ].each do |email|
      it "should accept #{email}" do
        validator.email = email
        validator.should be_valid
      end
    end
  end
  context "Invalid emails" do
    [
      'test test.com',
      'test+test@test.com',
      'test-test@test',
      'test!test@test.org',
      ' test-test@test.co.uk',
      'test@test,com',
      'test.test@test.com ',
    ].each do |email|
      it "should not accept #{email}" do
        validator.email = email
        validator.should_not be_valid
      end
    end
  end
end
