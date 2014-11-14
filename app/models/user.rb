class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

	#validates :username,
   # :uniqueness => {
   #   :case_sensitive => false
   # }
  attr_accessor :login
	has_one :user_info, :dependent => :destroy, :autosave => true
  has_many :bankcards
  has_many :coupons
  has_many :orders
  after_create :create_userinfo
  before_create :init_username
	def email_required?
		false
  end

  def init_username
    self.username = self.mobile if self.mobile != ""
    self.username = self.email if self.email != ""
  end


  def create_userinfo
    uinfo = UserInfo.new
    account = Account.new
    analyzer = Analyzer.new
    uinfo.account = account
    uinfo.analyzer = analyzer
    uinfo.show_id = self.username
    uinfo.payment_password = self.password
    self.user_info = uinfo
    account.save!
    uinfo.save!
  end


	def self.find_first_by_auth_conditions(warden_conditions)
		conditions = warden_conditions.dup
    #self.username =conditions[:login]
		if login = conditions.delete(:login)
      logger.info(login)
      where(conditions).where(["lower(mobile) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      logger.info("111111111111111")
			where(conditions).first
		end
  end


end
