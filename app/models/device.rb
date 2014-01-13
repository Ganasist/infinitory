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
	      pg_search(query)
	    else
	      scoped
	    end
	  end
end