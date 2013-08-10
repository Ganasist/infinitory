class Institute
	module UrlHelper
		extend ActiveSupport::Concern

		module ClassMethods
		  def url_with_protocol(url)
		    /^http/.match(url) ? url : "http://#{url}"
		  end
		end
	end
end
