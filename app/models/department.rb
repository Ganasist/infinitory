class Department < ActiveRecord::Base
	mount_uploader :icon, IconUploader
  process_in_background :icon

	belongs_to :institute
	validates_associated	:institute
  validates :institute, presence: true

	has_many :labs
	has_many :users

	before_validation :smart_add_url_protocol, :default_addresses

	# after_validation :reverse_geocode,
	# 								 :if => lambda { |t| t.address_changed? && t.address? }
	# after_validation :geocode,
	# 								 :if => lambda { |t| t.address_changed? && t.address? } # auto-fetch coordinates
  
  validates :name, presence: true, 
  								 uniqueness: { scope: :institute_id, case_sensitive: false, message: "A department with that name is already registered at this institute." }
  								 

	validates :url, allow_blank: true,
  								format: { with: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
  													multiline: true,
  													message: "is not valid" }

	geocoded_by :address # can also be an IP address
	reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	    obj.city    = geo.city
	    obj.country = geo.country
	  end
	end

	def location
		if self.room.present?
			"#{room} #{address}"
		else
			"#{address}"
		end
	end

	protected

		def smart_add_url_protocol
			if self.url.present?
			  unless self.url[/^http:\/\//] || self.url[/^https:\/\//]
			    self.url = 'http://' + self.url
			  end
			end
		end

		def default_addresses
			if self.institute.present?
				self.address = self.institute.address if self.address.blank?
				self.url = self.institute.url if self.url.blank?
				if self.longitude.nil?
					self.longitude = self.institute.longitude
					self.latitude = self.institute.latitude
				end
			end
		end
end
