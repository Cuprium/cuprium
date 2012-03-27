# This class coordinates the movement of money between accounts
# it creates the master Transaction with the correct references in it
class Transfer < Transaction

  class SameAccount < StandardError 
    def initialize(*args)
      super I18n.translate(:cannot_transfer_between_the_same_account)
    end
  end
  class NilAccount < StandardError 
    def initialize(*args)
      super I18n.translate(:transfer_needs_both_accounts_to_exist)
    end
  end
  class InvalidAmount < StandardError 
    def initialize(*args)
      super I18n.translate(:transfer_amount_must_be_greater_than_zero)
    end
  end

  attr_accessor :from_account, :to_account, :amount

  def initialize(values={})
    @from_account, @to_account, @amount = values[:from_account], values[:to_account], values[:amount]
  end

  def execute
    raise NilAccount if from_account.blank? || to_account.blank?
    raise SameAccount if from_account == to_account
    raise InvalidAmount if amount.blank? || amount.to_f <= 0.0
    transact do |transaction,cuprium_store|
      puts "block"
      transaction.activity = self.class.to_s
      cuprium_store.abort unless TransferIn.new(amount:amount,transaction:transaction.number,account:to_account).save &&
        TransferOut.new(amount:amount,transaction:transaction.number,account:from_account).save
    end
    self
  end

end