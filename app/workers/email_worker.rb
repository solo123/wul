class EmailWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false, :backtrace => true
  require "uri"

  def perform(addr, emailcode, email_type)
    if email_type == "reg"
      Reg.regist_confirm(addr, emailcode).deliver
    elsif email_type == "recover"
      Reg.reset_password(addr, emailcode).deliver
    else

    end
  end
end
