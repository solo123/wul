class Order < ActiveRecord::Base
  def create_transaction(account)
    trans = Transaction.new
    trans.trans_type = "order"
    trans.account_before =  trans.account_after = account.balance
    trans.frozen_before = account.frozen_balance
    trans.operation_amount = self.product_value
    trans.frozen_after = trans.frozen_before + self.product_value
    trans.save!
  end
end
