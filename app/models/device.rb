class Device < ActiveRecord::Base

	CATEGORIES = %w[calocages centrifuge confocal_microscope FACS PCR_machine RT-PCR telemetry_system]

	belongs_to :lab, counter_cache: true, touch: true
	validates_associated :lab
	validates_presence_of :lab

	has_many :ownerships
	has_many :users, through: :ownerships

	validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :price, numericality: { greater_than_or_equal_to: 0, message: 'Must be a positive number or 0' }, allow_blank: true
  validates :serial, unique: false, allow_blank: true, allow_nil: true

  validates :uid, allow_blank: true, uniqueness: { scope: [:lab_id, :category, :name], message: 'There is another device in the lab with that category, name and UID' }

  include PublicActivity::Common

	amoeba do
    enable
    customize(lambda { |original_device,new_device|
    	new_device.uid       = SecureRandom.hex(2)
    	new_device.activities = []
      if original_device.icon.present?
      	new_device.icon = original_device.icon
     	end
    })
  end

  attr_accessor :delete_icon
  attr_reader :icon_remote_url
  before_validation { icon.clear if delete_icon == '1' }
  has_attached_file :icon, styles: { thumb: '50x50>', portrait: '300x300>' }
  validates_attachment :icon, :size => { :in => 0..2.megabytes, message: 'Picture must be under 2 megabytes in size' }
  validates_attachment_content_type :icon, :content_type => /^image\/(png|gif|jpeg)/, :message => 'only (png/gif/jpeg) images'
  process_in_background :icon

  def icon_remote_url=(url_value)
     if url_value.present?
      self.icon = URI.parse(url_value)
      # Assuming url_value is http://example.com/photos/face.png
      # avatar_file_name == "face.png"
      # avatar_content_type == "image/png"
      @icon_remote_url = url_value
    end
  end

  include PgSearch
  pg_search_scope :pg_search, against: [:name, :uid, :serial],
                   				 		using: { tsearch: { prefix: true, dictionary: 'english' }}

	# mount_uploader :icon, IconUploader
	# process_in_background :icon
	
	acts_as_taggable
	scope :modified_recently, -> { order("updated_at DESC") }

	# store_accessor :properties, :description

	def relative_percentage(category)
    self.devices.where(category: category).count
  end

	def gl
    User.find_by(email: self.lab.email)
  end

  private
	  def self.text_search(query)
	    if query.present?
	      @devices = pg_search(query)
	    else
	      scoped
	    end
	  end
end