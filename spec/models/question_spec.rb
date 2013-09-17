require 'spec_helper'

describe Question do
  let(:question) { create(:question) }
  [:loan_product_id, :page, :text, :display_order, :kind].each do |mand_col|
    it { should validate_presence_of(mand_col) }
  end
  it { should belong_to(:loan_product) }
  Question::Kinds.each do |kind|
    it "accepts #{kind} as a valid value" do
      question.should be_valid
      question.kind = kind
      question.should be_valid
    end
  end
  it "does not accept invalid kind 'bob'" do
      question.should be_valid
      question.kind = 'bob'
      question.should_not be_valid    
  end
end
