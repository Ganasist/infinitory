$redis = Redis.new
REDIS = Redis.new(host: 'localhost', port: 6379)

# ENV["REDISTOGO_URL"] = 'redis://redistogo:2abe6b292108ffc35ff96cbf8bf99fea@grideye.redistogo.com:9438/'
# uri = URI.parse(ENV["REDISTOGO_URL"])
# REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)