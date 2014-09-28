class UserInfo < ActiveRecord::Base
	has_many :invests
  has_many :messages
  has_one :analyzer
  has_many :transactions
  has_many :account_operations
  has_one :verification
  has_one :delagator, :dependent=>:destroy, :autosave=>true
  has_one :account, :dependent=>:destroy, :autosave=>true
	belongs_to :user
  attr_accessor :sec_progress

  #after_create :create_delagator
  after_create :create_back_account
  def create_verification
   vef = Verification.new
   self.verification = vef
   vef.save!
  end


   def create_back_account
    op = AccountOperation.new(:op_name => "account", :op_action => "create", :uinfo_id => self.id, :operator => "system" )
    op.execute_transaction
   end


  def create_delagator
    delagator = Delagator.new
    delagator.last_invest_time = delagator.last_open_time = Time.now
    self.delagator = delagator
    delagator.save!
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
