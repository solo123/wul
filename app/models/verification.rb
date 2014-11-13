class Verification < ActiveRecord::Base
  attr_accessor :sec_progress
  def sec_progress
    if self.securyscore == 0
      self.securyscore
    elsif self.securyscore == 3
      100
    else
      self.securyscore * 33
    end
  end
end
