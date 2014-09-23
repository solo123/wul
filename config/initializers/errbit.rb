Airbrake.configure do |config|
  config.api_key = '3537004287e7703ab65f183003c38f80'
  config.host    = '127.0.0.1'
  config.port    = 3002
  config.secure  = config.port == 443
end