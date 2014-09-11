class Transaction < ActiveRecord::Base
  belongs_to :user_info
  after_save :modify_analyzer
  def Transaction.createTransaction(transtype, amount, amount_before, amount_after, userid, investid, product_type)
    trans= Transaction.new
    trans.trans_type = transtype
    trans.operation_amount = amount
    trans.account_before = amount_before
    trans.account_after = amount_after
    trans.user_info_id = userid
    trans.deposit_number = investid
    trans.product_type = product_type
    trans.save!
  end

  def modify_analyzer
    case self.trans_type
      when "charge"
        add_charge_data(self.user_info_id, self.operation_amount)
      else
    end
  end


  def add_charge_data(uinfo_id, amount)
    if uinfo = UserInfo.find(uinfo_id)
      uinfo.analyzer.total_charge_amount += amount
      uinfo.analyzer.save!
    end
  end
end
