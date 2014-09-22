class AccountOperation < ActiveRecord::Base
  belongs_to :user_info
  require 'net/https'
  require 'json'
  require "uri"
  $trans_url = "http://127.0.0.1:3001/accounting/account/execute_cmd"
  $query_url = "http://127.0.0.1:3001/accounting/account/query_cmd"
  attr_accessor :op_obj, :op_id_head


  def execute_transaction
    if !self.op_id_head
      self.op_id_head = "WY"
    end
    d = Time.now.to_i
    self.operation_id = self.op_id_head + d.to_s
    data = {:op_name => self.op_name, :op_amount => self.op_amount, :op_action => self.op_action, :operator => self.operator,
            :user_id => self.user_id, :operation_id => self.operation_id, :op_obj => self.op_obj, :op_resource_name => self.op_resource_name,
            :op_obj => self.op_obj, :op_resource_name => self.op_resource_name, :api_key => "secret", :uinfo_id => self.uinfo_id
    }
    # data = self.as_json
    self.save!
    # self.perform($trans_url, data, self.id)
    AccountWorker.perform_async($trans_url, data, self.id)
  end

  def execute_query
    uri = URI.parse($query_url)
    http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    data= {:api_key => "secret", :op_name => self.op_name, :op_amount => self.op_amount, :op_action => self.op_action, :operator => self.operator,
           :user_id => self.user_id, :operation_id => self.operation_id}
    request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    request.body = data.to_json
    response = http.request(request)
    op_res = JSON.parse response.body
  end


  def attach_action
    if self.op_result
       self.user_info_id = self.uinfo_id
       uinfo = UserInfo.find(self.user_info_id)
       if uinfo
         uinfo.account.pending_status = true
         uinfo.save!
       end
    end
  end

  def update_status
    if self.op_name == "account" && self.op_action == "charge"
      acc = self.user_info.account
      Transaction.createTransaction("charge", self.op_amount, acc.balance, self.op_amount + acc.balance, self.user_info_id, "充值", "charge")
      acc.balance += self.op_amount
      acc.save!
      self.user_info = nil
      self.save!
    end
  end

end
