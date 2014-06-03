require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ['john', 'loislane']
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['LIVE_REDISTOGO_URL'],
  								size: (Sidekiq.options[:concurrency]), 
  					 namespace: "infinitory_#{Rails.env}"}
  config.poll_interval = 15
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['LIVE_REDISTOGO_URL'],
  								size: (Sidekiq.options[:concurrency]),
  					 namespace: "infinitory_#{Rails.env}"}
end