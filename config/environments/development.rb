Infinitory::Application.configure do
  config.cache_classes = false

  config.i18n.enforce_available_locales = true

  config.eager_load = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.cache_store = :mem_cache_store

  config.action_mailer.default_url_options   = { host: 'localhost:3000' }
  config.action_mailer.delivery_method       = :smtp
  config.action_mailer.smtp_settings         = { address: 'localhost', port: 1025 }
  config.action_mailer.perform_deliveries    = true
  config.action_mailer.raise_delivery_errors = true

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.serve_static_assets = true

  # config.action_controller.asset_host =  "//#{ENV['S3_PRO_BUCKET_NAME']}.s3.amazonaws.com"
  # config.action_mailer.asset_host = "http://#{ENV['S3_PRO_BUCKET_NAME']}.s3.amazonaws.com"

  Paperclip.options[:command_path] = '/usr/local/bin/convert'

  ENV['NEW_RELIC_AGENT_ENABLED'] = 'false'

  # Braintree::Configuration.environment = :sandbox
  # Braintree::Configuration.merchant_id = ENV['BRAINTREE_MERCHANT_ID']
  # Braintree::Configuration.public_key = ENV['BRAINTREE_PUBLIC_KEY']
  # Braintree::Configuration.private_key = ENV['BRAINTREE_PRIVATE_KEY']
end