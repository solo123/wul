class Invest < ActiveRecord::Base
  belongs_to :user_info
  def create_transaction(account)
    trans = Transaction.new
    trans.trans_type = "invest"
    trans.account_before = account.balance
    trans.account_after =  account.balance - self.amount
    trans.frozen_before = account.frozen_balance
    trans.operation_amount = self.amount
    trans.frozen_after = trans.frozen_before
    trans.save!
  end
end
