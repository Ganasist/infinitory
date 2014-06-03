uri = URI.parse(ENV["LIVE_REDISTOGO_URL"])	
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)