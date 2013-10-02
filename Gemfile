source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '2.0.0'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'redis'
gem 'dalli'

gem 'friendly_id', '5.0.0.beta1'

gem 'paper_trail', '>= 3.0.0.beta1'

gem 'pg_search'
                             
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# bundle exec rake doc:rails generates the API under doc/api.

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"

# gem 'cancan'
gem 'devise'
gem 'devise_invitable', :github => 'scambra/devise_invitable'

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
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'consistency_fail'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'spork'
  gem 'spork-rails', github: 'railstutorial/spork-rails'
  gem 'guard-spork', :github => 'guard/guard-spork'
  gem 'growl_notify'
  gem 'turn'
  gem 'rspec-nc'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
end

