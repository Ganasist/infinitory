$redis = Redis.new
# REDIS = Redis.new(host: 'localhost', port: 6379)

# uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)