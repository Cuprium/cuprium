require 'account'
def find_or_create_account_numbered number
  @account = Account.find_by_number(number) || create(:account,number:number)
end
When(/^account "(.*?)" has a balance of (\d+\.\d\d)$/) do |number, balance|
  acc = find_or_create_account_numbered number
  acc.balance = BigDecimal.new balance
  acc.save!
end


