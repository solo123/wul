ADMIN_ROOT = '/home/wooul/admin.wooul.com/current'
ADMIN_PID_DIR = '/home/wooul/admin.wooul.com/shared/tmp/pids'
RAILS_ENV = 'production'
WEB_ROOT = '/home/wooul/www.wooul.com/current'
WEB_PID_DIR = '/home/wooul/www.wooul.com/shared/tmp/pids'
BIN_PATH   = "/usr/local/rvm/rubies/ruby-2.1.1/bin"
UID = 'wooul'
#GID = 'wooul'

God.log_file  = "/home/www/god/god.log"
God.log_level = :warn

%w(unicorn_ad sidekiq_ad).each do |config|
  God.load "#{ADMIN_ROOT}/config/#{config}.god"
end

%w(unicorn_web sidekiq_web).each do |config|
  God.load "#{WEB_ROOT}/config/#{config}.god"
end

