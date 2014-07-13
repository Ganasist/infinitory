class Department < ActiveRecord::Base

	include URLProtocols
  include Attachments

  has_merit
  acts_as_commentable

	belongs_to :institute
	validates_associated	:institute
  validates :institute, presence: true

	has_many :labs
	has_many :users

	validates :url,
            :twitter_url,
            :facebook_url,
            url: { allow_blank: true, message: "Invalid URL, please include http:// or https://" }

	validates :email, email: true, allow_blank: true, uniqueness: true

  validates :name, presence: true, 
  								 uniqueness: { scope: :institute_id,
  								 							 case_sensitive: false,
  								 							 message: "A department with that name is already registered at this institute." }

  # attr_accessor :delete_icon
  # attr_reader :icon_remote_url
  # before_validation { icon.clear if delete_icon == '1' }
  # has_attached_file :icon, styles: { thumb: '50x50>', portrait: '300x300>' }
  # validates_attachment :icon, :size => { :in => 0..2.megabytes, message: 'Picture must be under 2 megabytes in size' }
  # validates_attachment_content_type :icon, :content_type => /^image\/(png|gif|jpeg)/, :message => 'only (png/gif/jpeg) images'
  # process_in_background :icon

  before_destroy :remove_comments, unless: Proc.new { |d| d.comments.nil? }

  def remove_comments
    self.comments.destroy_all
  end
	
	# def icon_remote_url=(url_value)
 #    if url_value.present?
 #      self.icon = URI.parse(url_value)
 #      @icon_remote_url = url_value
 #    end
 #  end

	def location
		if self.room.present?
			"#{room} #{address}"
		else
			"#{address}"
		end
	end

	protected
		before_validation :default_addresses,
											if: Proc.new { |d| d.institute.present? && !d.address.present? && d.address_changed? }
		def default_addresses
			self.address = self.institute.address if self.address.blank?
		end
end
