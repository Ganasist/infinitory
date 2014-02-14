require 'sidekiq'
require 'sidekiq/web'

# ENV["REDIS_URL"] ||= "redis://localhost:6379"

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ['john', 'loislane']
end

# if Rails.env.development?
# 	Sidekiq.configure_server do |config|
# 	  config.redis = { url: ENV["REDIS_URL"], namespace: 'sidekiq' }
# 	end
	
#   Sidekiq.configure_client do |config|
#     config.redis = { url: ENV["REDIS_URL"], namespace: 'sidekiq'  }
#   end
# end

# if Rails.env.production?
	Sidekiq.configure_server do |config|
	  config.redis = { url: ENV['REDISTOGO_URL'], size: (Sidekiq.options[:concurrency] + 2), namespace: "infinitory_#{Rails.env}"}
	  config.poll_interval = 15
	end
	Sidekiq.configure_client do |config|
	  config.redis = { url: ENV['REDISTOGO_URL'], size: (Sidekiq.options[:concurrency] + 2), namespace: "infinitory_#{Rails.env}"}
	end
# end