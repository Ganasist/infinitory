if Rails.env.production?
  Braintree::Configuration.environment = Rails.env.staging? ? :sandbox : :production
  # Braintree::Configuration.merchant_id = ENV["braintree_merchant_id"]
  # Braintree::Configuration.public_key  = ENV["braintree_public_key"]
  # Braintree::Configuration.private_key = ENV["braintree_private_key"]
else
  Braintree::Configuration.environment = :sandbox
	Braintree::Configuration.merchant_id = ENV['braintree_merchant_id']
	Braintree::Configuration.public_key  = ENV['braintree_public_key']
	Braintree::Configuration.private_key = ENV['braintree_private_key']
end