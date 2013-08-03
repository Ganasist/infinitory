class Institute < ActiveRecord::Base

	has_many :departments, dependent: :destroy

	geocoded_by :address   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates

	reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	    obj.city    = geo.city
	    obj.country = geo.country
	  end
	end
	after_validation :reverse_geocode
	
end
