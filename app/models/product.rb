class Product < ActiveRecord::Base
  attr_accessor :current_action, :current_operation, :current_stage
  has_many :invests
  # def invests
  #   Invest.where(:loan_number => self.deposit_number)
  # end

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
    case self.current_stage
      when "融资中"
        "/products/#{self.product_type}/#{self.id}"
      when "收益中"
        "#"
      when "已到期"
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

end
