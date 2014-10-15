class SubAnalyzer < ActiveRecord::Base
	belongs_to :analyzer
  def current_profit
    return 0 if invests.size == 0
    invests.map(&:current_profit).reduce(:+)
  end

  def invests
    self.analyzer.user_info.invests.where(:invest_type => self.product_type)
  end

  def current_principal
    return 0 if invests.size == 0
    invests.map(&:current_principal).reduce(:+)
  end
end
