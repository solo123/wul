class Transaction < ActiveRecord::Base
  belongs_to :user_info
  def Transaction.createTransaction(transtype, amount, amount_before, amount_after, userid, investid)
    trans= Transaction.new
    trans.trans_type = transtype
    trans.operation_amount = amount
    trans.account_before = amount_before
    trans.account_after = amount_after
    trans.user_info_id = userid
    trans.save!
  end
end
