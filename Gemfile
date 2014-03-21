source 'https://rubygems.org'
ruby '2.1.1'
gem 'rails', '4.1.0.rc1'

gem 'sass-rails', '~> 4.0.0'

gem 'newrelic_rpm'
gem 'braintree'

gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

# gem 'bcrypt-ruby', '~> 3.0.0'
gem 'unicorn'
# gem 'capistrano', group: :development

gem 'debugger', group: [:development, :test]

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'kaminari'
gem 'bootstrap-kaminari-views'

gem 'google_visualr', '>= 2.1'

gem 'acts-as-taggable-on'
gem 'acts_as_commentable'

gem 'public_activity'

gem 'best_in_place', github: 'bernat/best_in_place'

gem 'exception_notification'

gem 'amoeba'

gem 'active_attr'
gem 'activerecord-import', '>= 0.2.0'

gem 'merit'

gem 'redis'
gem 'memcachier'
gem 'dalli'

gem 'friendly_id', '5.0.0.beta1'

# gem 'validates_timeliness', '~> 3.0'

gem 'email_validator', require: 'email_validator/strict'

gem 'pg_search'
gem 'hairtrigger'
                      
gem 'turbolinks'

gem 'therubyracer'
gem 'less-rails' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'twitter-bootstrap-rails'
gem 'font-awesome-rails'
gem 'bootstrap-switch-rails'

gem 'devise'
gem 'devise_invitable', github: 'scambra/devise_invitable'
gem 'devise-async'

gem 'figaro', github: 'laserlemon/figaro'
gem 'pg'
gem 'rolify'
gem 'simple_form'

gem 'high_voltage'

gem 'paperclip', '~> 4.1'
gem 'aws-sdk'
gem 'paperclip-aws'
gem 'delayed_paperclip'
gem 'rmagick'

gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'
gem 'sidetiq'

gem 'validate_url'

gem 'seed_dump'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'thin'
  # gem 'rack-mini-profiler'
  gem 'brakeman', :require => false
  # gem 'bullet'
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

gem 'faker', '~> 1.2.0'
gem 'factory_girl_rails'

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'shoulda-matchers'
  gem 'zeus-parallel_tests'
  gem 'rspec-nc'
  gem 'minitest'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
end