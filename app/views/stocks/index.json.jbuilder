json.array!(@stocks) do |stock|
  json.extract! stock, :id, :deposit_number, :invest_type, :amount, :user_id, :rate
  json.url stock_url(stock, format: :json)
end
