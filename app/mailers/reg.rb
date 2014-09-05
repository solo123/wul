class Reg < ActionMailer::Base
  default from: "dominic@pooul.cn"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.regconfirm.regist_confirm.subject
  #
  def regist_confirm(user)
    @userid= "dominic"
    @userhash="hash"
    @username = "dominic"
    mail :to=> "166706916@qq.com",:subject=>"沃银网注册确认"
  end

  def reset_password(user)
    @userid=user.id
    @userhash=user.hashed_password
    @username = user.name
    mail :to=>user.email,:subject=>"微行微系统密码重设"
  end
end