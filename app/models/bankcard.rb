class Bankcard < ActiveRecord::Base
  belongs_to :user_info
  def bank_list
  [['中国工商银行', 1],['中国农业银行', 2],['交通银行', 3],['中国银行', 4], ['中国建设银行', 5], ['光大银行', 6], ['中信', 7], ['平安银行', 8], ['浦发银行', 9]]
  end
end
