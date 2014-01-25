Infinitory::Application.configure do
  config.cache_classes = false

  config.i18n.enforce_available_locales = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.cache_store = :mem_cache_store

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { address: "localhost", port: 1025 }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.serve_static_assets = true

  Paperclip.options[:command_path] = '/usr/local/bin/'
end