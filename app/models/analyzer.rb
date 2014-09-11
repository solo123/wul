class Analyzer < ActiveRecord::Base
  belongs_to :user_info
  has_many :sub_analyzers
  after_create :init_analyzers

  def product(product_type)
      self.sub_analyzers.where(:product_type => product_type).first
  end

  def init_analyzers
     fixed = SubAnalyzer.new(:product_type => "fixed")
     month = SubAnalyzer.new(:product_type => "month")
     self.sub_analyzers << fixed
     self.sub_analyzers << month
     fixed.save!
     month.save!
  end
end
