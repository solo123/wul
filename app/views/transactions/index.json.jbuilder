json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :trans_type, :operation_amount, :account_before, :account_after, :frozen_before, :frozen_after
  json.url transaction_url(transaction, format: :json)
end
