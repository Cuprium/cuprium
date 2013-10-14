require 'spec_helper'

describe LoanApplication do
  let(:loan_application) { build(:loan_application) }
  let(:client) { build(:client) }
  [:client_details, :loan_product_id].each do |col|
    it { should validate_presence_of(col) }
  end
  it { should belong_to(:loan_product) }
  it "accept client data" do
    loan_application.client_details = nil
    loan_application.raw_client = client
    loan_application.client_details.should_not be_empty
  end
  it "rebuild client" do
    loan_application.raw_client = client
    rebuilt_client = loan_application.raw_client
    rebuilt_client.class.should == Client
    client.attributes.each_pair do |key,value|
      rebuilt_client[key].should eq value
    end
  end
  it "invalid if state is not set after create" do
    loan_application.save!
    loan_application.state = nil
    loan_application.should_not be_valid
  end
  it "initialise state" do
    loan_application = build(:loan_application, state: nil)
    loan_application.should be_valid
    loan_application.state.should eq "client_only"
  end
  context "pages" do
    let(:loan_product) { create(:loan_product) }
    let(:q1p1) { create(:question,loan_product_id: loan_product.id, text: "Q1" ) }
    let(:q2p1) { create(:question,loan_product_id: loan_product.id, text: "Q2", display_order: 2 ) }
    let(:q1p2) { create(:question,loan_product_id: loan_product.id, text: "Q3", page: 2) }

    before(:each) do
      loan_product
      q1p1
      q2p1
      q1p2
      loan_product.reload
    end
    it "build from questions" do
      loan_application = create(:loan_application,loan_product_id: loan_product.id)
      loan_application = LoanApplication.find(loan_application.id)
      loan_application.pages.size.should == 2
    end
    it "saves responses" do
      loan_application = create(:loan_application,loan_product_id: loan_product.id)
      loan_application.pages[0].questions[0].answer = 'yes'
      loan_application.save!
      loan_application.reload
      loan_application.pages[0].questions[0].answer.should eq 'yes'
    end
  end
end
