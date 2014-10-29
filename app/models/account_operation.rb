class AccountOperation < ActiveRecord::Base
  belongs_to :user_info
  require 'net/https'
  require 'json'
  require "uri"
  $trans_url = "http://127.0.0.1:8080/accounting/account/execute_cmd"
  $query_url = "http://127.0.0.1:8080/accounting/account/query_cmd"
  attr_accessor :op_obj, :op_id_head
  belongs_to :user_info


  def execute_transaction
    if !self.op_id_head
      self.op_id_head = "WY"
    end
    d = Time.now.to_i
    self.operation_id = self.op_id_head + d.to_s
    data = {:op_name => self.op_name, :op_amount => self.op_amount, :op_action => self.op_action, :operator => self.operator,
            :user_id => self.user_id, :operation_id => self.operation_id, :op_obj => self.op_obj, :op_resource_name => self.op_resource_name,
            :op_obj => self.op_obj, :op_resource_name => self.op_resource_name, :api_key => "secret", :uinfo_id => self.uinfo_id, :op_asset_id =>
            self.op_asset_id
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
      send(self.op_action + "_" + self.op_name)
    end
  end

  def charge_account
    uinfo = UserInfo.find(self.uinfo_id)
    acc = uinfo.account
    Transaction.createTransaction("charge", self.op_amount, acc.balance, self.op_amount + acc.balance, self.uinfo_id, "充值", "charge")
    acc.balance = self.op_result_value
    acc.save!
  end


  def join_invest

    product = Product.find(self.op_resource_id)
    userinfo = UserInfo.find(self.uinfo_id)
    product.free_invest_amount -= self.op_amount
    product.fixed_invest_amount += self.op_amount
    product.owner_num += 1
    product.save!

    invest = Invest.new
    invest.invest_type = product.product_type
    invest.asset_id = self.op_asset_id
    invest.amount = self.op_amount
    invest.loan_number = product.deposit_number
    invest.annual_rate = product.annual_rate
    invest.owner_name = userinfo.user.username
    userinfo.invests << invest
    product.invests << invest

    userinfo.account.balance = self.op_result_value
    userinfo.save!
    invest.save!
    balance = userinfo.account.balance
    Transaction.createTransaction("invest", invest.amount, balance + invest.amount, balance, userinfo.id,  product.deposit_number, product.product_type)
  end



  def create_account

  end


  def onsale_invest
    invest = Invest.find(self.op_resource_id)
    invest.resell_price = self.op_result_value.to_f
    invest.discount_rate = self.op_amount
    invest.onsale = true
    invest.save!
  end

  def buy_invest
    invest = Invest.find(self.op_resource_id)
    buyer_balance = self.op_result_value.to_f
    seller_balance = self.op_result_value2.to_f
    logger.info("uinfo id is:#{self.uinfo_id}")
    Account.update_balance(self.uinfo_id, buyer_balance)
    Transaction.createTransaction("buy", self.op_amount, buyer_balance, buyer_balance + self.op_amount, self.uinfo_id,  invest.loan_number, invest.product.product_type)
    Account.update_balance(self.uinfo_id2, self.op_result_value2)
    Transaction.createTransaction("sell", self.op_amount, seller_balance, seller_balance - self.op_amount, self.uinfo_id2,  invest.loan_number, invest.product.product_type)
    invest.user_info_id = self.uinfo_id
    invest.owner_name = self.user_info.user.username
    invest.onsale = false
    invest.stage = "normal"
    invest.save!
  end


  def fill_params(params)
    self.op_result = params["op_result"]
    self.op_amount = params["op_amount"]
    self.op_asset_id = params["op_asset_id"]
    self.op_result_code = params["op_result_code"]
    self.op_result_value = params["op_result_value"]
    self.uinfo_id2 = params["uinfo_id2"]
    self.op_result_value2 = params["op_result_value2"]
  end

end
