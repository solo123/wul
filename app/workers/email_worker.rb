class EmailWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false ,:backtrace => true
  require "uri"
  def perform(addr, emailcode)
    Reg.regist_confirm(addr, emailcode).deliver
  end
end
