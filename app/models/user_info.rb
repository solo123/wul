class UserInfo < ActiveRecord::Base
	has_many :invests
  has_many :transactions
  has_one :verification
  has_one :account, :dependent=>:destroy, :autosave=>true
	belongs_to :user
  attr_accessor :sec_progress

  #after_create :create_verification

  def create_verification
   vef = Verification.new
   self.verification = vef
   vef.save!
  end

  def sec_progress
    if self.secury_score == 0
      self.secury_score
    elsif self.secury_score == 3
      100
    else
      self.secury_score * 33
    end
  end
end
