# $redis = Redis.new(host: 'localhost', port: 6379)
# REDIS = Redis.new(host: 'localhost', port: 6379)

uri = URI.parse(ENV["REDISCLOUD_URL"] || "redis://localhost:6379/" )
$redis = REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)