Paperclip::Attachment.default_options[:url]						 = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] 					 = '/:class/:attachment/:id_partition/:style/:filename'
Paperclip::Attachment.default_options[:storage]        = :s3
Paperclip::Attachment.default_options[:s3_credentials] = { :bucket => ENV['S3_BUCKET_NAME'],
																											     :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
																											     :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'] }																											    
Paperclip::Attachment.default_options[:s3_permissions] = :public_read
Paperclip::Attachment.default_options[:s3_protocol]    = 'http'
Paperclip::Attachment.default_options[:s3_options]     = { :server_side_encryption => 'AES256',
																								           :storage_class => :reduced_redundancy,
																								           :content_disposition => 'attachment' }