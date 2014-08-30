class Product < ActiveRecord::Base
  attr_accessor :invests, :current_action, :current_operation, :current_stage

  def invests
    Invest.where(:loan_number => self.deposit_number)
  end

  def current_stage

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

  end
end
