require 'spec_helper'

describe Client do
  context "valdation" do
    [
      :title_id,
      :first_name,
      :last_name,
      :address1,
      :town,
      :postcode,
    ].each do |col|
      it { should validate_presence_of col }
    end
    it "validates postcode" do
      pending
    end
    it "validates email" do
      pending
    end
  end

end
