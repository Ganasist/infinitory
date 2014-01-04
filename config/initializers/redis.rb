$redis = Redis.new
# REDIS = Redis.new(host: 'localhost', port: 6379)

# ENV["REDISTOGO_URL"] = 'redis://username:password@my.host:6389'
uri = URI.parse("redis://username:password@my.host:6389")
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)