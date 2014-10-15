class Message < ActiveRecord::Base
  after_create :update_user_info
  attr_accessor :read_status
  belongs_to :user_info

  def update_user_info
    uinfo = self.user_info
    uinfo.message_num += 1
    uinfo.notify_num += 1
    uinfo.save!
  end

  def read_status
    if self.status == 1
     "已读"
    else
    "未读"
    end
  end
end
