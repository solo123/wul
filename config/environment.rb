# Load the Rails application.
require File.expand_path('../application', __FILE__)
Wooul::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :address => "smtp.exmail.qq.com",
      :port => 25,
      :domain => "exmail.qq.com",
      :authentication => "login",
      :user_name => "dominic@pooul.cn",
      :password => "wqxyy1985",
      :enable_starttls_auto => true
  }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
end

# Initialize the Rails application.
Wooul::Application.initialize!
