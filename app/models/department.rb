class Department < ActiveRecord::Base
	belongs_to :institute
	has_many :labs, dependent: :destroy

	after_validation :smart_add_url_protocol
	after_validation :reverse_geocode
	after_validation :geocode     # auto-fetch coordinates

  validates_associated :institute
  validates :name, :address, presence: true
  validates :url, :format =>{ :with => /((http|https):\/\/)?[a-z0-9]+([-.]{1}[a-z0-9]+).[a-z]{2,5}(:[0-9]{1,5})?(\/.)?/ix,
  														:message => " is not valid" }

  validates :name, uniqueness: {scope: :institute_id, 
  													  message: "That department has already been registered at this institute."}


	geocoded_by :address   				# can also be an IP address
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
	  unless self.url[/^http:\/\//] || self.url[/^https:\/\//]
	    self.url = 'http://' + self.url
	  end
	end

end
