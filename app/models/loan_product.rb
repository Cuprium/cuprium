class LoanProduct < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :questions
  has_many :loan_applications
end
