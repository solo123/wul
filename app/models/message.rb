class Message < ActiveRecord::Base
  after_create :update_user_info
  belongs_to :user_info
  def update_user_info
    uinfo = self.user_info
    uinfo.message_num += 1
    uinfo.notify_num += 1
    uinfo.save!
  end
end
