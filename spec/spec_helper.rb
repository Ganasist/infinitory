require 'rubygems'
require 'test/unit'

ENV['RAILS_ENV'] = 'test'
require File.expand_path("../../config/environment", __FILE__)
# require 'minitest/autorun'
require 'rspec/rails'
require 'capybara/rspec'
require 'email_spec'
require 'sidekiq/testing'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

Devise::Async.enabled = false

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|

  config.alias_example_to :expect_it

  config.include FactoryGirl::Syntax::Methods

  config.include Devise::TestHelpers, :type => :controller
  config.include ControllerHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller
  
  config.include RSpec::Rails::RequestExampleGroup, type: :feature

  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)

  # Options to speed up the tests!!
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.before(:each) { GC.disable }
  config.after(:each) { GC.enable }
  config.before(:all) do
    DeferredGarbageCollection.start
  end
  config.after(:all) do
    DeferredGarbageCollection.reconsider
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

RSpec::Core::MemoizedHelpers.module_eval do
  alias to should
  alias to_not should_not
end
