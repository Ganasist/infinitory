class Institute < ActiveRecord::Base

	extend FriendlyId
	friendly_id :acronym_and_name, use: :slugged

	has_many :departments, dependent: :destroy
	has_many :labs, dependent: :destroy
	has_many :labs, through: :departments, dependent: :destroy

	before_validation :smart_add_url_protocol
	after_validation :geocode   # auto-fetch coordinates
	after_validation :reverse_geocode

	validates :name, :address, presence: true
	validates :name, uniqueness: { scope: :address,
    													 	 message: "This institute is already registered at that address" }

  validates :url, :format =>{ with: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
  														multiline: true,
  														message: "is not valid" }

	geocoded_by :address   			# can also be an IP address
	reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	    obj.city    = geo.city
	    obj.country = geo.country
	  end
	end

	acts_as_gmappable validation: false

	protected

		def gmaps4rails_address
		#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
		  "#{self.latitude}, #{self.longitude}" 
		end

		def smart_add_url_protocol
			if self.url.present?
			  unless self.url[/^http:\/\//] || self.url[/^https:\/\//]
			    self.url = 'http://' + self.url
			  end
			end
		end

		def acronym_and_name
	    if self.acronym.present?
	    	[
	    		:acronym,
	    		[:acronym, :city]
	    	]
	    else
		    "#{name}"
	    end
	  end
end
