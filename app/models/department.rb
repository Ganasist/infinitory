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

  before_destroy :remove_comments, unless: Proc.new { |d| d.comments.nil? }

  def remove_comments
    self.comments.destroy_all
  end

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
