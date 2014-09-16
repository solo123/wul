class Analyzer < ActiveRecord::Base
  belongs_to :user_info
  has_many :sub_analyzers
  after_create :init_analyzers

  def product(product_type)
      dict = {"fixed" => 0, "month" => 1}
      self.sub_analyzers[dict[product_type]]
  end

  def init_analyzers
     fixed = SubAnalyzer.new(:product_type => "fixed")
     month = SubAnalyzer.new(:product_type => "month")
     self.sub_analyzers << fixed
     self.sub_analyzers << month
     fixed.save!
     month.save!
  end

  def total_invest_amount
    self.sub_analyzers.map(&:total_invest_amount).reduce(:+)
  end

end
