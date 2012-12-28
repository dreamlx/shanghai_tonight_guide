require 'bundler/capistrano'
set :user, 'dreamlinx'
set :domain, 'www.qiaobei.info'
set :applicationdir, '/home/dreamlinx/shanghai_tonight_guide'
set :application, "qiaobei"
set :scm, 'git'
set :repository,  "git@github.com:dreamlx/shanghai_tonight_guide.git"
set :git_enable_submodules, 1 # if you have vendored rails
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "www.qiaobei.info"                          # Your HTTP server, Apache/etc
role :app, "www.qiaobei.info"                          # This may be the same as your `Web` server
role :db,  "www.qiaobei.info", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# deploy config
set :deploy_to, applicationdir
set :deploy_via, :export

# Passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
