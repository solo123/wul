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
        add_charge_data
      when "invest"
        add_analyzer_data("total_invest_amount")
      else
    end
  end


  def add_charge_data
    if uinfo = UserInfo.find(self.user_info_id)
      uinfo.analyzer.total_charge_amount += self.operation_amount
      uinfo.analyzer.save!
    end
  end

  def add_analyzer_data(field)
    if uinfo = UserInfo.find(self.user_info_id)
      a = uinfo.analyzer.product(self.product_type)
      a.send(field + '=', a.send(field) + self.operation_amount)
      a.save!
    end
  end

end
