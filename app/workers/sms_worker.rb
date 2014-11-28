class SmsWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false, :backtrace => true
  require "uri"
  require 'net/https'

  def perform( mobile, message)
    uri = URI('https://sms-api.luosimao.com/v1/send.json')
    Net::HTTP.start(uri.host, uri.port,
                    :use_ssl => uri.scheme == 'https',
                    :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

      request = Net::HTTP::Post.new uri.path
      data = {'mobile' => mobile, 'cb' => 'callback', 'message' => message}
      request.form_data = data
      request.basic_auth 'api', 'd5e425886c61049dc6d652f3e2a74b21'
      response = http.request request # Net::HTTPResponse object
       puts response
       puts response.body
    end
  end
end
