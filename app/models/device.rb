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


  validates :product_url, presence: true, url: true, allow_blank: true
  validates :purchasing_url, presence: true, url: true, allow_blank: true
  
  validates :uid, allow_blank: true, uniqueness: { scope: [:lab_id, :category, :name], message: 'There is another device in the lab with that category, name and UID' }

  after_update  :online_status_message, if: Proc.new { |d| d.status_changed? }

  include PublicActivity::Common

  attr_accessor :delete_icon
  attr_reader :icon_remote_url  
  before_validation { icon.clear if delete_icon == '1' }
  has_attached_file :icon, styles: { thumb: '50x50>', original: '450x300>' }                   
  validates_attachment :icon, :size => { :in => 0..2.megabytes, message: 'Picture must be under 2 megabytes in size' }
  validates_attachment_content_type :icon,
                                    :content_type => /^image\/(png|gif|jpeg)/,
                                    :message => 'only (png/gif/jpeg) images'
  process_in_background :icon
  
  attr_accessor :delete_pdf
  attr_reader :pdf_remote_url
  before_validation { pdf.clear if delete_pdf == '1' }
  has_attached_file :pdf                
  validates_attachment :pdf, :size => { :in => 0..5.megabytes, message: 'File must be under 3 megabytes in size' }
  validates_attachment_content_type :pdf,
                                    :content_type => 'application/pdf',
                                    :message => 'only PDF files allowed'
                                    
  include PgSearch
  pg_search_scope :pg_search, against: [:name, :uid, :serial],
                   				 		using: { tsearch: { prefix: true, dictionary: 'english' } }

	acts_as_taggable
	scope :modified_recently, -> { order("updated_at DESC") }

	# store_accessor :properties, :description
  
  amoeba do
    enable
    customize(lambda { |original_device,new_device|
      new_device.uid       = SecureRandom.hex(2)
      new_device.activities = []
      if original_device.icon.present?
        new_device.icon = original_device.icon
      end
      if original_device.pdf.present?
        new_device.pdf = original_device.pdf
      end
    })
  end

  def icon_remote_url=(url_value)
     if url_value.present?
      self.icon = URI.parse(url_value)
      @icon_remote_url = url_value
    end
  end

  def pdf_remote_url=(url_value)
     if url_value.present?
      self.pdf = URI.parse(url_value)
      @pdf_remote_url = url_value
    end
  end

	def relative_percentage(category)
    self.devices.where(category: category).count
  end

	def gl
    User.find_by(email: self.lab.email)
  end

  def online_status_message
    if self.location.present?
      if self.status?
        comment = "#{ self.fullname } (#{ self.location }) was taken online"
      else
        comment = "#{ self.fullname } (#{ self.location }) was taken offline"
      end
    else
      if self.status?
        comment = "#{ self.fullname } was taken online"
      else
        comment = "#{ self.fullname } was taken offline"
      end
    end
    self.users.each do |u|
      u.comments.create(comment: comment)
    end
    self.lab.comments.create(comment: comment)
  end

  def fullname
    if self.uid.present?
      "#{self.name}-#{self.uid}"
    else
      "#{self.name}"
    end
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