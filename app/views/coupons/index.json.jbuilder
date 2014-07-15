json.array!(@coupons) do |coupon|
  json.extract! coupon, :id, :user_id, :amount, :title, :desc
  json.url coupon_url(coupon, format: :json)
end
