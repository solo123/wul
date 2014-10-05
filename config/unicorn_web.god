#RAILS_ENV  = ENV['RAILS_ENV']  = 'production'
#RAILS_ROOT = ENV['RAILS_ROOT'] = '/home/www/wul'
#PID_DIR    = '/home/www/wul/tmp/pids'
#BIN_PATH   = "/usr/local/rvm/rubies/ruby-2.1.1/bin"
#UID = 'root'
#GID = 'root'

God.watch do |w|
  w.dir      = "#{WEB_ROOT}"
  w.name     = "unicorn_web"
  w.interval = 30.seconds
  w.group = "web"
  w.start   = "cd #{WEB_ROOT} && unicorn_rails -c #{WEB_ROOT}/config/unicorn.rb -E #{RAILS_ENV} -D"
  w.stop    = "kill -QUIT `cat #{WEB_PID_DIR}/unicorn.pid`"
  w.restart = "kill -USR2 `cat #{WEB_PID_DIR}/unicorn.pid`"

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds

  w.uid = UID
  w.gid = GID

  w.pid_file = "#{WEB_PID_DIR}/unicorn.pid"
  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 100.megabytes
      c.times = [3, 5] # 3 out of 5 intervals
    end

    restart.condition(:cpu_usage) do |c|
      c.above = 50.percent
      c.times = 5
    end
  end

  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end
