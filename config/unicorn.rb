worker_processes 2 

# Since Unicorn is never exposed to outside clients, it does not need to

# "current" directory that Capistrano sets up.
APP_PATH = "/home/mycloud/wul_web"
DEPLOY_PATH = "/home/wooul/wooul.com"
working_directory APP_PATH + "/current"  # available in 0.94.0+

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen APP_PATH+"/shared/tmp/sockets/unicorn.sock", :backlog => 64


# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

# feel free to point this anywhere accessible on the filesystem
pid APP_PATH+"/shared/tmp/pids/unicorn.pid"

# By default, the Unicorn logger will write to stderr.
# Additionally, ome applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
stderr_path APP_PATH+"/shared/log/wooul.stderr.log"
stdout_path APP_PATH+"/shared/log/wooul.stdout.log"

# combine Ruby 2.0.0dev or REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true


before_exec do |server|
   ENV['BUNDLE_GEMFILE'] = APP_PATH + "/current/Gemfile"
end
# Enable this flag to have unicorn test client connections by writing the
# beginning of the HTTP headers before calling the application.  This
# prevents calling the application for connections that have disconnected
# while queued.  This is only guaranteed to detect clients on the same
# host unicorn runs on, and unlikely to detect disconnects even on a
# fast LAN.
check_client_connection false

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
    
    
old_pid = "#{server.config[:pid]}.oldbin"
   if old_pid != server.pid
      begin
         sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
         Process.kill(sig, File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
      end
   end
  # sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
