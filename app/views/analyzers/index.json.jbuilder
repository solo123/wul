json.array!(@analyzers) do |analyzer|
  json.extract! analyzer, :id, :product, :owner_num, :invest_num
  json.url analyzer_url(analyzer, format: :json)
end
