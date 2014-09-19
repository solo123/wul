class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :deposit_number
  attr_accessor :current_action, :current_operation, :current_stage, :remain_repayment_period
  has_many :invests
  has_one :agreement
  # def invests
  #   Invest.where(:loan_number => self.deposit_number)
  # end


  def current_stage

  end

  def remain_repayment_period
    months_between(self.profit_date, self.expiring_date)
  end



  def months_between(begin_date, end_date)
    (end_date.year * 12 + end_date.month) - (begin_date.year * 12 + begin_date.month)
  end

  def current_operation
    case self.current_stage
      when "融资中"
        "加入"
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
      when "融资中"
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

  def product_name
    dict = {"fixed" => "定存宝",
            "month" => "月月盈"}
    dict[self.product_type]
  end

  def repayment_method_name
    dict = {"profit" => "收益返还",
            "profit_principal" => "本息返还"}
    dict[self.repayment_method]
  end

end
