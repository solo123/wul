class Reg < ActionMailer::Base
  default from: "dominic@pooul.cn"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.regconfirm.regist_confirm.subject
  #
  def regist_confirm(email, code)
    @username= email
    @userhash = code
    mail :to => email,:subject=>"沃银网注册确认"
  end


  def reset_password(email, code)
    @username= email
    @userhash = code
    mail :to=> email,:subject => "沃银网密码重设"
  end
end