source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '2.0.0'
gem 'rails', '4.0.0'

gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.0.0'

# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'gon'
gem 'jbuilder'
gem 'active_model_serializers'
gem 'rabl'
gem 'oj'

gem 'redis'
gem 'dalli'

gem 'friendly_id', '5.0.0.beta1'

gem 'paper_trail', '>= 3.0.0.beta1'

gem 'pg_search'
                             
gem 'turbolinks'

# bundle exec rake doc:rails generates the API under doc/api.

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# gem 'debugger', group: [:development, :test]

gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"

gem 'devise'
gem 'devise_invitable', :github => 'scambra/devise_invitable'
gem 'devise-async'

gem 'figaro'
gem 'pg'
gem 'rolify'
gem 'simple_form', '>= 3.0.0.rc'

gem 'thin'
gem 'high_voltage'
gem 'geocoder'
gem 'gmaps4rails'

gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'

gem 'carrierwave'
gem 'carrierwave_backgrounder'
gem "rmagick"

gem 'will_paginate'
gem 'seed_dump'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'rack-mini-profiler'
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rb-fchange', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', :require => false
  gem 'consistency_fail'
  gem 'parallel_tests'
end

group :development, :test do
  gem "faker", "~> 1.2.0"
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'zeus-parallel_tests'
  # gem 'growl_notify'
  # gem 'turn'
  gem 'rspec-nc'
  gem 'minitest'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
end

