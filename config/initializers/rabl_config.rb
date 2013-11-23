Rabl.configure do |config|
	config.cache_sources = Rails.env # Defaults to false
	config.cache_all_output = false
  config.include_json_root = false
  config.include_child_root = false
end