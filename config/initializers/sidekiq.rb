Sidekiq.configure_client do |config|
  config.redis = {:namespace => 'wul', :url => 'redis://127.0.0.1:6379/1'}
end

Sidekiq.configure_server do |config|
  config.error_handlers << Proc.new { |ex, context| Airbrake.notify_or_ignore(ex, parameters: context) }
  config.redis = {:namespace => 'wul', :url => 'redis://127.0.0.1:6379/1'}
end