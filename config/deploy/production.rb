# Base production capistrano config
set :stage, :production
set :branch, :production
set :rails_env, :production

# RVM ruby version along with gemset
set :rvm_ruby_version, '2.7.1@sch'

server 'app@46.101.190.227', roles: %i[web app db]
