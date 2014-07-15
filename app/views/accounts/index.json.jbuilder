json.array!(@accounts) do |account|
  json.extract! account, :id, :useable_balance, :balance, :frozen_balance, :total_estate
  json.url account_url(account, format: :json)
end
