class AccountOperation < ActiveRecord::Base
  require 'net/https'
  require 'json'
  require "uri"
  attr_accessor :op_obj

  $trans_url = "http://127.0.0.1:3001/accounting/account/execute_cmd"
  $query_url = "http://127.0.0.1:3001/accounting/account/query_cmd"

  def execute_transaction
    operation_id = "WO20140917" + rand(10 ** 6).to_s
    uri = URI.parse($trans_url)
    http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    data= {:api_key => "secret", :op_name => self.op_name, :op_amount => self.op_amount, :op_action => self.op_action, :operator => self.operator,
    :user_id => self.user_id, :operation_id => operation_id, :op_obj => self.op_obj}
    request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
    request.body = data.to_json
    response = http.request(request)
    op_res = JSON.parse response.body
    logger.info(op_res["op_result"])
    logger.info(op_res["op_result_code"])
    # rec = new(:op_name => op_name, :op_action => op_action, :op_amount => op_amount, :operator => operator,
    #                            :op_result_code => op_res["op_result_code"],:op_result => op_res["op_result"],
    #                            :user_id => uid, :operation_id => op_id)
    # rec.save!
  end


  def execute_query
    uri = URI.parse($query_url)
    http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    data= {:api_key => "secret", :op_name => self.op_name, :op_amount => self.op_amount, :op_action => self.op_action, :operator => self.operator,
           :user_id => self.user_id, :operation_id => self.operation_id}
    request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
    request.body = data.to_json
    response = http.request(request)
    op_res = JSON.parse response.body
  end




  # def record(op_name, op_amount, op_action, operator, op_res)
  #   rec = AccountOperation.new(:op_name => op_name, :op_action => op_action, :op_amount => op_amount, :operator => operator,
  #                                          :op_result_code => op_res["op_result_code"],:op_result => op_res["op_result"] )
  #   rec.save!
  # end

end
