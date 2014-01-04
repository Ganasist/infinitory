$redis = Redis.new

ENV["REDISTOGO_URL"] = 'redis://username:password@my.host:6389'
uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)