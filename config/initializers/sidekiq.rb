require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["john", "loislane"]
end

# if Rails.env.development?
# 	Sidekiq.configure_server do |config|
# 	  config.redis = { :url => 'redis://localhost:6379/0', :namespace => "infinitory_#{Rails.env}" }
# 	end
# 	Sidekiq.configure_client do |config|
# 	  config.redis = { :url => 'redis://localhost:6379/0', :namespace => "infinitory_#{Rails.env}" }
# 	end
# end

if Rails.env.production? || Rails.env.staging?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDISTOGO_URL'], size: (Sidekiq.options[:concurrency] + 2)}
    config.poll_interval = 15
  end
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end
end