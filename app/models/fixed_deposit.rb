class FixedDeposit < ActiveRecord::Base
  attr_accessor :invests,:current_action, :current_operation, :current_stage
  def invests
    Invest.where(:loan_number => self.deposit_number)
  end

  def current_stage
    if self.expiring_date < Time.now.yesterday && self.stage!="已结束"
      "已到期"
    elsif self.stage == "已结束"
      self.display = "hide"
      self.save!
    else
      self.stage
    end
  end

  def current_operation
    case self.current_stage
      when "融资中"
        "加入"
      when "收益中"
        "收益中"
      when "已到期"
        "回款中"
    end
  end

  def current_action
    case self.current_stage
      when "未发布"
        "/fixed_deposits/publish.#{self.id}"
      when "融资中"
        "/fixed_deposits/#{self.id}"
      when "收益中"
        "#"
      when "已到期"
        "#"
      when "已结束"
        "/fixed_deposits/refund.#{self.id}"
    end
  end




end
