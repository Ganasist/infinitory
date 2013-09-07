class Department < ActiveRecord::Base
	belongs_to :institute, touch: true
	has_many :labs, dependent: :destroy
	has_many :group_leaders, through: :labs, dependent: :destroy

	before_validation :smart_add_url_protocol

	after_validation :reverse_geocode,
									 :if => lambda { |t| t.address_changed? && t.address? }
	after_validation :geocode,
									 :if => lambda { |t| t.address_changed? && t.address? } # auto-fetch coordinates

  validates_associated :institute

  validates :name, :institute_id, presence: true

  validates :url, allow_blank: true,
  								format: { with: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
  													multiline: true,
  													message: "is not valid" }

  validates :name, uniqueness: { scope: :institute_id, 
  													  	 message: "That department has already been registered at this institute." }


	geocoded_by :address  				# can also be an IP address
	reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	    obj.city    = geo.city
	    obj.country = geo.country
	  end
	end

	acts_as_gmappable validation: false

	def test
		"#{name} at #{institute.name}"
	end

	def location
		if self.room.present?
			"#{room} #{address}"
		else
			"#{address}"
		end
	end

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
end
