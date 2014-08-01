class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

	validates :username,
    :uniqueness => {
      :case_sensitive => false
    }
  attr_accessor :login
	has_one :user_info, :dependent=>:destroy, :autosave=>true
  has_many :bankcards
  has_many :coupons
  has_many :orders
  after_create :create_userinfo

	def email_required?
		false
  end

  def create_userinfo
    uinfo = UserInfo.new
    account = Account.new
    uinfo.account = account
    uinfo.show_id = self.username
    self.user_info = uinfo
    account.save!
    uinfo.save!
  end


	def self.find_first_by_auth_conditions(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
		else
			where(conditions).first
		end
	end
end
