require 'spec_helper'

describe Transaction do

  let(:transaction) { build( :transaction ) }

  context "valdation" do
    [:activity].each do |col|
      it { should validate_presence_of col }
    end
  end

end
