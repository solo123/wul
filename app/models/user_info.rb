class UserInfo < ActiveRecord::Base
	has_many :invests
  has_many :transactions
  has_one :verification
  has_one :account, :dependent=>:destroy, :autosave=>true
	belongs_to :user

  after_create :create_verification

  def create_verification
   vef = Verification.new
   self.verification = vef
   vef.save!
  end
end
