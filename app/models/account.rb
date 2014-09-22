class Account < ActiveRecord::Base
  belongs_to :user_info
  def current_balance
    if self.pending_status
      self.update_account
      self.balance
    else
      self.balance
    end
  end

  def update_account
    self.user_info.account_operations.each do |op|
      op.update_status
    end
    self.pending_status = false
    self.save!
  end
end
