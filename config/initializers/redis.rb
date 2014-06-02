# if Rails.env.development?
# 	REDIS = Redis.new(host: 'localhost', port: 6379)
# elsif Rails.env.production?
# if Rails.env.development? || Rails.env.staging?
# 	uri = URI.parse(ENV["STAGING_REDISTOGO_URL"])
# elsif Rails.env.production?
	# uri = URI.parse(ENV["LIVE_REDISTOGO_URL"])
# end

	uri = URI.parse(ENV["LIVE_REDISTOGO_URL"])	
	REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
# end