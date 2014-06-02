require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ['john', 'loislane']
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['LIVE_REDISTOGO_URL'], size: (Sidekiq.options[:concurrency] + 2), namespace: "infinitory_#{Rails.env}"}
  config.poll_interval = 15
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['LIVE_REDISTOGO_URL'], size: (Sidekiq.options[:concurrency] + 2), namespace: "infinitory_#{Rails.env}"}
end

# if Rails.env.production?
# Sidekiq.configure_server do |config|
#   config.redis = { url: ENV['LIVE_REDISTOGO_URL'], size: (Sidekiq.options[:concurrency] + 2), namespace: "infinitory_#{Rails.env}"}
#   config.poll_interval = 15
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: ENV['LIVE_REDISTOGO_URL'], size: (Sidekiq.options[:concurrency] + 2), namespace: "infinitory_#{Rails.env}"}
# end
# elsif Rails.env.development? || Rails.env.staging?
# 	Sidekiq.configure_server do |config|
# 	  config.redis = { url: ENV["STAGING_REDISTOGO_URL"], size: (Sidekiq.options[:concurrency]), namespace: 'sidekiq' }
# 	end
#   Sidekiq.configure_client do |config|
#     config.redis = { url: ENV["STAGING_REDISTOGO_URL"], namespace: "infinitory_#{Rails.env}"  }
#   end
# end
