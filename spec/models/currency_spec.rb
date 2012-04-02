require 'spec_helper'

describe Currency do
  [:code,:name,:decimal_places,:iso_number].each { |col| it { should validate_presence_of col }}
  it { should have_many(:accounts) }
end
