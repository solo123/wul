json.array!(@invests) do |invest|
  json.extract! invest, :jkbh, :jybh
  json.url invest_url(invest, format: :json)
end
