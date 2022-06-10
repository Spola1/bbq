# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "bbqrails"
set :repo_url, "git@github.com:Spola1/bbq.git"

set :deploy_to, "/home/deploy/www"

append :linked_files, "config/database.yml", "config/master.key", ".env"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

after "deploy:restart", "resque:restart"

set :branch, "main"
