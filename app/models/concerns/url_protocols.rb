# Included in User, Lab, Department, Institute
module URLProtocols
	extend ActiveSupport::Concern

	included do
		before_validation :smart_add_url_protocol,
											if: Proc.new { |d| d.url.present? && d.url_changed? }
	end

	private
		def smart_add_url_protocol
		  unless self.url[/^http:\/\//] || self.url[/^https:\/\//]
		    self.url = 'http://' + self.url
		  end
		end
end