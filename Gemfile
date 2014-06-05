source 'https://rubygems.org'
ruby '2.1.1'
gem 'rails', '4.1.0.rc2'

gem 'sass-rails', '~> 4.0.0'

gem 'fullcalendar-rails'
gem 'validates_overlap'

gem 'bitly', '~> 0.9.0'

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

gem 'yaml_db', github: 'jetthoughts/yaml_db', ref: 'fb4b6bd7e12de3cffa93e0a298a1e5253d7e92ba'

gem 'jbuilder'

gem 'kaminari'
gem 'bootstrap-kaminari-views'

gem 'google_visualr', '>= 2.1'

gem 'oink'

gem 'acts-as-taggable-on'
gem 'acts_as_commentable'

gem 'public_activity'

gem 'best_in_place', github: 'bernat/best_in_place'

gem 'exception_notification'

gem 'amoeba'

gem 'state_machine'
gem 'ruby-graphviz', :require => 'graphviz'

gem 'active_attr'
gem 'activerecord-import', '>= 0.2.0'

gem 'merit'

gem 'redis'
gem 'memcachier'
gem 'dalli'

# gem 'friendly_id', '5.0.0.beta1'

# gem 'validates_timeliness', '~> 3.0'

gem 'email_validator', require: 'email_validator/strict'

gem 'pg_search'
gem 'hairtrigger'

# gem 'postgres_ext', '~> 2.1.3'
                      
gem 'turbolinks'

gem 'therubyracer'
gem 'less-rails' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'twitter-bootstrap-rails'
gem 'font-awesome-rails'
gem 'bootstrap-switch-rails'

gem 'devise', '~> 3.0'
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

gem 'sidekiq', '~> 2.17.7'
gem 'sinatra', require: false
gem 'slim'
gem 'sidetiq'

gem 'validate_url'

gem 'seed_dump'

gem 'asset_sync'
gem 'fog'
gem 'unf'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'spring'
  gem 'thin'
  # gem 'rack-mini-profiler'
  gem 'brakeman', :require => false
  # gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rb-fchange', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', :require => false
  gem 'consistency_fail'
  gem 'parallel_tests'
end

gem 'faker', '~> 1.2.0'
gem 'factory_girl_rails', :require => false

group :development, :test do
  gem 'guard-rspec', '~> 4.2.6', git: 'https://github.com/guard/guard-rspec.git', branch: 'master'
  gem 'rspec', '~> 3.0.0.beta2'
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'rspec-nc'
  gem 'minitest'
  gem 'shoulda-matchers'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
end