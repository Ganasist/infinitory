class Device < ActiveRecord::Base

  CURRENCIES = %w[$ €]

  acts_as_taggable_on :category

	belongs_to :lab, counter_cache: true, touch: true
	validates_associated :lab
	validates_presence_of :lab

	has_many :ownerships, dependent: :destroy
	has_many :users, through: :ownerships

  has_many :bookings, dependent: :destroy
  has_many :user_bookings, through: :bookings, class_name: 'User', foreign_key: 'user_id', source: :user

	validates :name, presence: true
  # validates :category, inclusion: { in: Proc.new { |device| device.lab.device_category_list }, message: "This device's category must belong to the lab's general category list." }
  validates :currency, inclusion: { in: CURRENCIES }
  validates :price, numericality: { greater_than_or_equal_to: 0, message: 'Must be a positive number or 0' }, allow_blank: true
  validates :serial, unique: false, allow_blank: true, allow_nil: true

  validates_length_of :description, maximum: 223

  validates :product_url, presence: true, url: true, allow_blank: true
  validates :purchasing_url, presence: true, url: true, allow_blank: true
  
  validates :uid, allow_blank: true, uniqueness: { scope: [:lab_id, :name], message: 'There is another device in the lab with that category, name and UID' }

  include PublicActivity::Common

  attr_accessor :delete_icon
  attr_reader :icon_remote_url  
  before_validation { icon.clear if delete_icon == '1' }
  has_attached_file :icon, styles: { thumb: '50x50>', original: '450x450>' }                   
  validates_attachment :icon, :size => { :in => 0..2.megabytes, message: 'Picture must be less than 2 megabytes' }
  validates_attachment_content_type :icon,
                                    :content_type => /^image\/(png|gif|jpeg)/,
                                    :message => 'only (png/gif/jpeg) images'
  process_in_background :icon
  
  attr_accessor :delete_pdf
  attr_reader :pdf_remote_url
  before_validation { pdf.clear if delete_pdf == '1' }
  has_attached_file :pdf                
  validates_attachment :pdf, :size => { :in => 0..5.megabytes, message: 'File must be less than 3 megabytes' }
  validates_attachment_content_type :pdf,
                                    :content_type => 'application/pdf',
                                    :message => 'only PDF files allowed'
                                    
  include PgSearch
  pg_search_scope :pg_search, against: [:name, :uid, :serial],
                   				 		using: { tsearch: { prefix: true, dictionary: 'english' } }

	scope :modified_recently, -> { order("updated_at DESC") }
  
  amoeba do
    enable
    customize(lambda { |original_device, new_device|
      new_device.uid        = SecureRandom.hex(2)
      new_device.activities = []
      new_device.bookings   = []
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

	def gl
    User.find_by(email: self.lab.email)
  end

  def fullname
    if self.uid.present? && self.location.present?
        "#{self.name}-#{self.uid} (#{self.location})"
    elsif self.uid.present? && !self.location.present?
        "#{self.name}-#{self.uid}"
    elsif !self.uid.present? && self.location.present?
      "#{self.name} (#{self.location})"
    elsif !self.uid.present? && !self.location.present?
      "#{self.name}"
    end
  end

  after_save :online_status_worker, if: Proc.new { |d| d.status_changed? }
  def online_status_worker
    OnlineStatusWorker.perform_async(self.id)    
  end

  after_save :share_status_worker, if: Proc.new { |d| d.shared_changed? }
  def share_status_worker
    ShareStatusWorker.perform_async("device", self.id)
  end

  after_save :location_status_worker, if: Proc.new { |d| d.location_changed? }
  def location_status_worker
    LocationStatusWorker.perform_async("device", self.id)
  end

  private
    before_validation :smart_add_product_url_protocol,
                      if: Proc.new { |d| d.product_url_changed? && d.product_url.present? }
    def smart_add_product_url_protocol
      unless self.product_url[/^http:\/\//] || self.product_url[/^https:\/\//]
        self.product_url = 'http://' + self.product_url
      end
    end

    before_validation :smart_add_purchasing_url_protocol,
                      if: Proc.new { |d| d.purchasing_url_changed? && d.purchasing_url.present? }
    def smart_add_purchasing_url_protocol
      unless self.purchasing_url[/^http:\/\//] || self.purchasing_url[/^https:\/\//]
        self.purchasing_url = 'http://' + self.purchasing_url
      end
    end

	  def self.text_search(query)
	    if query.present?
	      @devices = pg_search(query)
	    else
	      scoped
	    end
	  end
end