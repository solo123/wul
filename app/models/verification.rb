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

  def safe_questions
    [['您母亲的姓名是？', 1],['您父亲的姓名是？', 2],['您的出生地是？', 3],['您最喜欢的食物是？', 4]]
  end

end
