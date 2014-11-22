class Transaction < ActiveRecord::Base
  belongs_to :user_info
  after_save :modify_analyzer
  scope :charges, -> { where(trans_type:['charge','pull']) }
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
    trans.create_notify
  end

  def create_notify
    message = Message.new()
    case self.trans_type
      when "charge"
        message.title = "充值成功"
        message.content = "您于#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}，在沃银网充值人民币#{self.operation_amount}元成功."
      when "invest"
        message.title = "投资成功"
        message.content = "您于#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}，在沃银网投资产品#{self.deposit_number},投资金额为#{self.operation_amount}元的操作成功."
      when "sell"
        message.title = "转让债权"
        message.title = "您于#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}，在沃银网转让产品#{self.deposit_number}的债权,债权金额为#{self.operation_amount}元, 已经成功完成."
      when "buy"
        message.title = "买入债权"
        message.title = "您于#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}，在沃银网买入产品#{self.deposit_number}的债权,债权金额为#{self.operation_amount}元, 已经成功完成."
      else
    end
    message.user_info_id = self.user_info_id
    message.save!
  end

  def modify_analyzer
    case self.trans_type
      when "charge"
        add_charge_data
      when "invest"
        add_analyzer_data("total_invest_amount")
      when "sell"
        add_analyzer_data("resell_amount")
      when "buy"
        add_analyzer_data("buyin_amount")
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
