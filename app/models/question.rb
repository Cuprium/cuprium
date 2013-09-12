class Question < ActiveRecord::Base
  attr_accessible :loan_product_id, :page, :text
  validates_presence_of :loan_product_id, :page, :text
  belongs_to :loan_product
end
