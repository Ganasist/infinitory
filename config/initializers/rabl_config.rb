Rabl.configure do |config|
	config.cache_sources = Rails.env != 'development' # Defaults to false
	config.cache_all_output = true
  config.include_json_root = false
  config.include_child_root = false
end