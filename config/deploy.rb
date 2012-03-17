require 'bundler/capistrano'
load 'deploy/assets'

set :application, "cuprium"
set :server_name, "cuprium.railsbaby.com"
set :keep_releases, 4
set :repository,  "git@github.com:Cuprium/cuprium.git"

set :scm, :git

set :deploy_to, "/usr/share/nginx/#{server_name}"
set :scm, :git
set :deploy_via, :remote_cache

default_run_options[:pty] = true
set :port, 4014
set :use_sudo, true

set :scm_verbose, true
set :branch, "master"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache

server "#{server_name}", :app, :web, :db, :primary => true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do

  after "deploy:finalize_update", "deploy:config:link_database_config"
  after "deploy:finalize_update", "deploy:config:link_pstore"

  namespace :config do

    desc "Link in the production database.yml"
    task :link_database_config do
      sudo "ln -nfs #{deploy_to}/database.yml #{release_path}/config/database.yml"
    end 
    desc "set up the pstore share"
    task :link_pstore do
      sudo "touch #{deploy_to}/shared/cuuprium_store.pstore"
      sudo "ln -nfs #{deploy_to}/shared/cuuprium_store.pstore #{release_path}"
      run("cd #{deploy_to}/current && /usr/bin/env rake db:seed RAILS_ENV=production")
    end 
    desc "reset pstore"
    task :reset_pstore do
      sudo "rm #{deploy_to}/shared/cuuprium_store.pstore"
      sudo "touch #{deploy_to}/shared/cuuprium_store.pstore"
      sudo "ln -nfs #{deploy_to}/shared/cuuprium_store.pstore #{release_path}"
      run("cd #{deploy_to}/current && /usr/bin/env rake db:seed RAILS_ENV=production")      
    end

  end

  namespace :unicorn do
    desc "Start"
    task :start do
      sudo "service cuprium_unicorn start"    
    end
    desc "Stop"
    task :stop do
      sudo "service cuprium_unicorn stop"    
    end
    desc "restart"
    task :restart do
      # Note that we stop and start in case the current directory symlink has changed
      # sometimes it keeps the old file handle so a clean stop/start seems better
      sudo "service cuprium_unicorn stop"
      sleep 5
      sudo "service cuprium_unicorn start"    
    end
  end

  namespace :nginx do
    desc "Start"
    task :start do
      sudo "service nginx start"    
    end
    desc "Stop"
    task :stop do
      sudo "service nginx stop"    
    end
    desc "restart"
    task :restart do
      sudo "service nginx restart"    
    end
  end
end

namespace :setup do
  desc "Link the nginx files"
  task :nginx do
    sudo "ln -nfs #{deploy_to}/current/config/nginx.conf /etc/nginx/sites-available/cuprium.railsbaby.com"
    sudo "service nginx restart"
  end
  desc "Create unicorn ini files"
  task :unicorn do
    sudo "ln -nfs #{deploy_to}/current/config/unicorn_init.sh /etc/init.d/cuprium_unicorn"
    sudo "service cuprium_unicorn stop"    
    sleep 5
    sudo "service cuprium_unicorn start"    
  end
end

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end