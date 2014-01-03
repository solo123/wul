class UserInfo < ActiveRecord::Base
	has_many :invests
	belongs_to :user
end
