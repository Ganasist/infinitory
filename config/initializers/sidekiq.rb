require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["john", "loislane"]
end

if Rails.env.production? || Rails.env.staging?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'] }
    config.poll_interval = 15
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end
end