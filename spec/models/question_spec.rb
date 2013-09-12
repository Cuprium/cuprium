require 'spec_helper'

describe Question do
  [:loan_product_id, :page, :text].each do |mand_col|
    it { should validate_presence_of(mand_col) }
  end
  it { should belong_to(:loan_product) }
end
