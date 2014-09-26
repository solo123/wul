class AccountWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false ,:backtrace => true
  require "uri"
  def perform(url, data, record_id)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
    request.body = data.to_json
    response = http.request(request)
    op_res = JSON.parse response.body
    record = AccountOperation.find(record_id)
    record.fill_params(op_res)
    logger.info(op_res)
    record.attach_action
    record.save!
  end
end