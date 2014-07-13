module ItemURLProtocols
	extend ActiveSupport::Concern

	included do
		before_validation :smart_add_product_url_protocol,
                      if: Proc.new { |i| i.product_url.present? && i.product_url_changed? }
  	before_validation :smart_add_purchasing_url_protocol,
                      if: Proc.new { |i| i.purchasing_url.present? && i.purchasing_url_changed? }
  end

  private
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