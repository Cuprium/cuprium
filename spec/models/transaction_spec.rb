require 'spec_helper'

describe Transaction do

  context "valdation" do
    [:activity, :from_conversion_id, :to_conversion_id].each do |col|
      it { should validate_presence_of col }
    end
  end

  context "relations" do
    it { should belong_to(:from_conversion) }
    it { should belong_to(:to_conversion) }
  end
end
