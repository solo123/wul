Airbrake.configure do |config|
  config.api_key = '5bf1238e387b064e748e8e038375e800'
  config.host    = '122.112.89.151'
  config.port    = 3001
  config.secure  = config.port == 443
  config.development_environments = []
end