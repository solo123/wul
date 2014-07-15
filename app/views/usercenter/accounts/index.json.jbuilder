json.array!(@usercenter_accounts) do |usercenter_account|
  json.extract! usercenter_account, :id, :user_id, :useable_balance, :balance, :frozen_balance, :total_estate
  json.url usercenter_account_url(usercenter_account, format: :json)
end
