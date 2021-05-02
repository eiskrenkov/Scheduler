source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Core
gem 'rails', '~> 6.0'
gem 'puma'
gem 'mysql2'
gem 'devise'
gem 'enumerate_it'
gem 'cocoon'
gem 'simple_form'
gem 'inherited_resources'
gem 'faraday'

# Telegram
gem 'omniauth-telegram'

# Frontend
gem 'bootstrap'
gem 'jquery-rails'
gem 'slim'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'font-awesome-rails'
gem 'bootstrap-select-rails'

# Additional
gem 'bootsnap', '~> 1.3', require: false

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'annotate', '~> 2.7.1'

  # Code analysis
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-thread_safety', require: false
  gem 'rubocop-rspec', require: false

  # Deployment
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger', '>= 0.1.1'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :production do
  gem 'redis-rails'
end
