#require 'bundler/capistrano' 
  

default_run_options[:pty] = true  # Must be set for the password prompt
                                  # from git to work
ssh_options[:forward_agent] = true
set :application, "qiaobei"
set :repository,  "git@github.com:dreamlx/shanghai_tonight_guide.git"
set :deploy_to, "/home/dreamlinx/tonight_guide"
set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
set :user, "dreamlinx"
set :scm_passphrase, "spt2melx"
set :branch, "master"
set :deploy_via, :remote_cache
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :domain, "www.qiaobei.info"
role :web, domain
role :app, domain
role :db,  domain, :primary => true # This is where Rails migrations will run
role :db,  domain

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do 
     # nothing
   end
   task :stop do 
     # nothing
   end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
