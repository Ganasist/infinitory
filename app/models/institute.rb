class Institute < ActiveRecord::Base

	geocoded_by :name   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates

	reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	  	obj.address = geo.address
	    obj.city    = geo.city
	    obj.country = geo.country_code
	  end
	end
	after_validation :reverse_geocode
end
