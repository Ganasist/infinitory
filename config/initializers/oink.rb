# if Rails.env.production? || Rails.env.staging?
# 	Rails.application.middleware.use( Oink::Middleware, logger: Hodel3000CompliantLogger.new(STDOUT))
# elsif Rails.env.development?
# 	Rails.application.middleware.use( Oink::Middleware, logger: Rails.logger)
# end