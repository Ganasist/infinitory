class Institute < ActiveRecord::Base
	mount_uploader :icon, IconUploader

	extend FriendlyId
	friendly_id :acronym_and_name, use: [:slugged, :history]

	include PgSearch
  pg_search_scope :search, against: [:name, :acronym, :alternate_name],
                  using: { tsearch: { prefix: true,
                  										dictionary: "english" }}

	has_many :departments
	has_many :labs
	has_many :users

	before_validation :smart_add_url_protocol

	after_validation :geocode, 
									 :if => lambda { |t| t.address_changed? && t.address.present? }
	after_validation :reverse_geocode, 
									 :if => lambda { |t| t.address_changed? && t.address.present? }
	# validates :name, uniqueness: { scope: :address,
  #    													 	 message: "This institute is already registered at that address" },
  #    								:if => :address.present?, allow_blank: true
  
	validates :url, allow_blank: true,
  								format: { with: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
  													multiline: true,
  													message: "is not valid" }

	
	geocoded_by :address
	reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	    obj.city    = geo.city
	    obj.country = geo.country
	  end
	end

	acts_as_gmappable validation: false

	protected
		def gmaps4rails_address
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
	    if self.acronym.blank?
	    	"#{name}"
	    else
		    [
	    		"#{acronym}",
	    		["#{acronym}", "#{city}"]
	    	]
	    end
	  end

	  def should_generate_new_friendly_id?
		  new_record? || slug.blank?
		end

		def self.global_search(query)
	    if query.present?
	      search(query)
	    else
	      scoped
	    end
	  end
end
