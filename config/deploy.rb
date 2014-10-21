require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/unicorn'
require 'mina_sidekiq/tasks'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
require 'mina/rvm'    # for rvm support. (http://rvm.io)
set :rvm_path, '/home/mycloud/.rvm/bin/rvm'

#invoke :'rvm:use[ruby-2.1.1@default]'
# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)
set :force_assets, 1
set :user, "mycloud"
set :domain, 'www.wooul.com'
set :deploy_to, '/home/mycloud/wul_web'
set :repository, 'git://github.com/solo123/wul.git'
set :branch, 'background'
set :unicorn_pid, "#{deploy_to}/shared/tmp/pids/unicorn.pid"
set :sidekiq_pid, "#{deploy_to}/shared/tmp/pids/sidekiq.pid"
set :sidekiq_log, "#{deploy_to}/shared/log/sidekiq.log"
# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['log']

# Optional settings:
#   set :user, 'foobar'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  # invoke :'rbenv:load'
  
invoke :'rvm:use[ruby-2.1.1@default]'
  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-1.9.3-p125@default]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]
    
  
  queue! %[mkdir -p "#{deploy_to}/shared/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp"]

    
  queue! %[mkdir -p "#{deploy_to}/shared/tmp/sockets"]
  queue! %[mkdir -p "#{deploy_to}/shared/tmp/pids"]
   
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/pids"]


 queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    
    # invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
       
    invoke :'rails:assets_precompile'
    #queue! %[cd "#{deploy_to}/current" && rake comfortable_mexican_sofa:fixtures:import FROM=wooul-20141014 TO=wul]
    to :launch do
      invoke :cms
      queue! %[god restart web]
    end
  end
end


desc "First deploy"
task :firstdeploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    
    # invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    to :launch do
      queue! %[god -c /home/mycloud/god/startgod.god -l /home/mycloud/god/god.log -P /home/mycloud/god/god.pid]
    end
  end
end


desc "CMS installing"
task :cms do
  queue %[cd #{deploy_to}/current &&  rake comfortable_mexican_sofa:fixtures:import FROM=wooul-20141017 TO=wul]
end


desc "Shows logs."
task :logs do
  queue %[cd #{deploy_to} && tail -f logs/error.log]
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

