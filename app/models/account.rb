class Account < ActiveRecord::Base
  belongs_to :user_info
  def Account.update_balance(uinfo_id, amount)
    uinfo = UserInfo.find(uinfo_id)
    if uinfo
      uinfo.account.balance = amount
      uinfo.account.save!
    end
  end
end
