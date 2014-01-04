$redis = Redis.new
# REDIS = Redis.new(host: 'localhost', port: 6379)

# ENV["REDISTOGO_URL"] = 'redis://username:password@my.host:6389'
uri = URI.parse("redis://redistogo:2abe6b292108ffc35ff96cbf8bf99fea@grideye.redistogo.com:9438/")
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)