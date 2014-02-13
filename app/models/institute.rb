class Institute < ActiveRecord::Base
	has_many :departments
	has_many :labs
	has_many :users

	validates :name, uniqueness: { scope: :address, case_sensitive: false, message: "This institute is already registered at that address" },
									 							 if: Proc.new{ |f| f.address? }

  validates :name, presence: true, allow_blank: false

  validates :email, email: true, allow_blank: true, uniqueness: true
 
	before_validation :smart_add_url_protocol, if: Proc.new { |i| i.url.present? && i.url_changed? }

	validates :url, url: { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
  validates :linkedin_url, url: { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
  validates :xing_url, url: { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
  validates :twitter_url, url: { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
  validates :facebook_url, url: { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
  validates :google_plus_url, url: { allow_blank: true, message: "Invalid URL, please include http:// or https://" }

	attr_accessor :delete_icon
  attr_reader :icon_remote_url
  before_validation { icon.clear if delete_icon == '1' }
  has_attached_file :icon, styles: { thumb: '50x50>', portrait: '300x300>' }
  validates_attachment :icon, :size => { :in => 0..2.megabytes, message: 'Picture must be under 2 megabytes in size' }
  validates_attachment_content_type :icon, :content_type => /^image\/(png|gif|jpeg)/, :message => 'only (png/gif/jpeg) images'
  process_in_background :icon

	extend FriendlyId
	friendly_id :acronym_and_name, use: [:slugged, :history]

	include PgSearch
  pg_search_scope :search, against: [:name, :acronym, :alternate_name, :city],
                  using: { tsearch: { prefix: true,
                  										dictionary: "english" }}

	def icon_remote_url=(url_value)
  	if url_value.present?
    	self.icon = URI.parse(url_value)
    	@icon_remote_url = url_value
  	end
  end

	protected

		def smart_add_url_protocol
		  unless self.url[/^http:\/\//] || self.url[/^https:\/\//]
		    self.url = 'http://' + self.url
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
