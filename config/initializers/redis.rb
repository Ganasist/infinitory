# $redis = Redis.new(host: 'localhost', port: 6379)
# REDIS = Redis.new(host: 'localhost', port: 6379)

# ENV["REDISTOGO_URL"] = 'redis://redistogo:2abe6b292108ffc35ff96cbf8bf99fea@grideye.redistogo.com:9438/'
uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/" )
$redis = REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)