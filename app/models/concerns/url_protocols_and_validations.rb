# Included in User, Lab, Department, Institute
module URLProtocolsAndValidations
	extend ActiveSupport::Concern

	included do
		if self.class.name != "User"
			before_validation :smart_add_url_protocol,
											if: Proc.new { |i| i.url.present? && i.url_changed? }
			validates :url,
								:twitter_url,
								:facebook_url,
								url: { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
		elsif self.class.name == "User"
			validates :linkedin_url,
		            :xing_url,
		            :twitter_url,
		            :facebook_url,
		            url: { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
		end
	end

	private
		def smart_add_url_protocol
		  unless self.url[/^http:\/\//] || self.url[/^https:\/\//]
		    self.url = 'http://' + self.url
		  end
		end
end