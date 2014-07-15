json.array!(@bankcards) do |bankcard|
  json.extract! bankcard, :id, :user_id, :bankname, :cardid
  json.url bankcard_url(bankcard, format: :json)
end
