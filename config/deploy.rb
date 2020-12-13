# Base application info
set :application, 'scheduler'
set :application_abbr, 'SCH'
set :repo_url, 'git@github.com:eiskrenkov/Scheduler.git'
set :keep_releases, 2
set :default_env, -> { { rails_env: fetch(:rails_env), node_env: :production } }

# Custom RVM path
set :rvm_custom_path, '/usr/share/rvm'

# Linked files and directories
set :linked_dirs, %w[log tmp/pids tmp/cache]
