class Invest < ActiveRecord::Base
  belongs_to :user_info
  belongs_to :product
  attr_accessor :product_name

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

  def product_name
    if self.invest_type == "fixed"
      "定存宝"
    elsif self.invest_type == "month"
      "月月盈"
    else
      ""
    end
  end

  def profit?
    Time.now >= self.product.profit_date + self.product.each_repayment_period.days
  end

  def current_profit
    profit?? calculate_profit : 0
  end

  def calculate_profit
    (self.amount * self.annual_rate / 12 /100).round(2)
  end

end
