class LoanApplication < ActiveRecord::Base
  attr_accessible :client_details, :client_id, :loan_product_id, :responses, :state
  validates_presence_of :client_details, :loan_product_id, :state
  belongs_to :loan_product
  serialize :responses
  before_validation(on: :create) do
    self.state ||= "client_only"
    default_responses
  end
  def raw_client= client
    self.client_details = client.attributes.to_json
  end
  def raw_client
    Client.new(JSON.parse(client_details)) if client_details.present?
  end
  def pages
    default_responses
  end
  private
  def default_responses
    return [] unless loan_product
    self.responses = generate_responses if responses.blank?
    responses
  end
  def generate_responses
    Array.new.tap do |_responses|
      page = LoanPage.new
      last_page_number = -1
      loan_product.questions.in_order.each do |question|
        if question.page != last_page_number
          unless last_page_number == -1
            _responses << page
            page = LoanPage.new
          end
        end
        page.questions << LoanQuestionResponse.new(question.id,question.text,"")
        last_page_number = question.page
      end
      _responses << page
    end
  end
end
