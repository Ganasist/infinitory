class Institute < ActiveRecord::Base

	include URLProtocols
	include Attachments

  has_merit
  acts_as_commentable

	has_many :departments
	has_many :labs
	has_many :users

	validates :name, uniqueness: { scope: :address, case_sensitive: false, message: "This institute is already registered at that address" },
									 							 if: Proc.new{ |f| f.address? }

  validates :name, presence: true, allow_blank: false

  validates :email, email: true, allow_blank: true, uniqueness: true

	validates :url,
						:twitter_url,
						:facebook_url,
						url: { allow_blank: true, message: "Invalid URL, please include http:// or https://" }

	# attr_accessor :delete_icon
 #  attr_reader :icon_remote_url
 #  before_validation { icon.clear if delete_icon == '1' }
 #  has_attached_file :icon, styles: { thumb: '50x50>', portrait: '300x300>' }
 #  validates_attachment :icon, :size => { :in => 0..2.megabytes, message: 'Picture must be under 2 megabytes in size' }
 #  validates_attachment_content_type :icon, :content_type => /^image\/(png|gif|jpeg)/, :message => 'only (png/gif/jpeg) images'
 #  process_in_background :icon

	include PgSearch
  pg_search_scope :search, against: [:name, :acronym, :alternate_name, :city],
                  using: { tsearch: { prefix: true,
                  										dictionary: "english" }}

	# def icon_remote_url=(url_value)
 #  	if url_value.present?
 #    	self.icon = URI.parse(url_value)
 #    	@icon_remote_url = url_value
 #  	end
 #  end

  before_destroy :remove_comments,
  							 unless: Proc.new { |i| i.comments.nil? }
  def remove_comments
    self.comments.destroy_all
  end

	protected
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

		def self.global_search(query)
	    if query.present?
	      search(query)
	    else
	      scoped
	    end
	  end
end
