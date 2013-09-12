class Question < ActiveRecord::Base
  attr_accessible :loan_product_id, :page, :text, :display_order
  validates_presence_of :loan_product_id, :page, :text, :display_order
  belongs_to :loan_product
end
