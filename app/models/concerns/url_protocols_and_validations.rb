# Included in Device, Reagent, User, Lab, Department, Institute
module URLProtocolsAndValidations
	extend ActiveSupport::Concern
	extend ActiveModel::Naming

	included do
		case self.name
		when "User"
			validates :linkedin_url,
                :xing_url,
                :twitter_url,
                :facebook_url,
                url: { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
		when "Lab" || "Department" || "Institute"
			before_validation :smart_add_url_protocol,
											if: Proc.new { |i| i.url.present? && i.url_changed? }
			validates :url,
								:twitter_url,
								:facebook_url,
								url: { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
		when "Device" || "Reagent"
			before_validation :smart_add_product_url_protocol,
                      if: Proc.new { |i| i.product_url.present? && i.product_url_changed? }
	  	before_validation :smart_add_purchasing_url_protocol,
                      if: Proc.new { |i| i.purchasing_url.present? && i.purchasing_url_changed? }
		end
	end

	private
		def smart_add_url_protocol
		  unless self.url[/^http:\/\//] || self.url[/^https:\/\//]
		    self.url = 'http://' + self.url
		  end
		end

		def smart_add_product_url_protocol
	    unless self.product_url[/^http:\/\//] || self.product_url[/^https:\/\//]
	      self.product_url = 'http://' + self.product_url
	    end
	  end	  
	  
	  def smart_add_purchasing_url_protocol
	    unless self.purchasing_url[/^http:\/\//] || self.purchasing_url[/^https:\/\//]
	      self.purchasing_url = 'http://' + self.purchasing_url
	    end
	  end
end