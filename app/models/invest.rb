class Invest < ActiveRecord::Base
  belongs_to :user_info
  belongs_to :product
  has_many :invest_profits
  attr_accessor :product_name
  extend FriendlyId
  friendly_id :invest_number

  def resell(rate)
    self.onsale = true
    self.resell_price = self.amount * (100 - rate) /100
    self.discount_rate = rate
    self.save!
  end


  def create_transaction(account)
    trans = Transaction.new
    trans.trans_type = "invest"
    trans.account_before = account.balance
    trans.account_after = account.balance - self.amount
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

  # def profit?
  #   Time.now >= self.product.profit_date + self.product.each_repayment_period.days
  # end

  def profit?
    false
    # p = self.product
    # end_date = p.join_date + (p.each_repayment_period * p.repayment_period).days
    # (end_date < Date.today) && ( p.last_profit_date + p.each_repayment_period.days <= end_date)
  end

  def current_profit
    profit? ? calculate_profit : 0
  end

  def calculate_profit
    (self.amount * self.annual_rate * self.each_repayment_period / 365 /100).round(2)
  end

  def redemable
    if self.product.premature_redemption == "yes"

      if self.product.stage == "融资中"
        "presale"
      elsif self.product.stage == "收益中"
        "profit"
      else
        "over"
      end
    else
      "cantsell"
    end
  end


  def resell_value
    if self.resell_price
       self.resell_price.round(1)
    else
      "审核中"
    end
  end


  def current_operation
    case self.current_stage
      when "normal"
        "转让"
      when "收益中"
        "收益中"
      when "已到期"
        "回款中"
      when "已结束"
        "已结束"
    end
  end

  def current_action
    case self.current_stage
      when "normal"
        "/products/#{self.product_type}/#{self.deposit_number}"
      when "收益中"
        "#"
      when "已到期"
        "#"
      when "已结束"
        "#"
    end
  end

  def current_stage
    self.stage
  end

  def secret_name
    if self.owner_name == ""
      "保密"
    else
      self.owner_name[0, 2] + "***" + self.owner_name[-2, 2]
    end
  end

end
