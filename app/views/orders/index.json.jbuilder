json.array!(@orders) do |order|
  json.extract! order, :id, :product_type, :product_name, :product_value, :product_id
  json.url order_url(order, format: :json)
end
