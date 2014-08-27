class Invest < ActiveRecord::Base
  belongs_to :user_info
  attr_accessor :product, :product_name
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

  def product
    if self.invest_type=="fixed"
       FixedDeposit.where(:deposit_number => self.loan_number).first
    elsif self.invest_type=="month"
       MonthDeposit.where(:deposit_number => self.loan_number).first
    end
  end

  def product_name
    if self.invest_type == "fixed"
      "定存宝"
    elsif self.invest_type == "month"
      "月月盈"
    else
      ""
    end
  end
end
