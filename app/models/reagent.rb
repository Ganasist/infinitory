class Reagent < ActiveRecord::Base

	CATEGORIES = %w[antibody cell_culture cell_line chemical_(powder) chemical_(solution) enzyme kit vector]

	belongs_to :lab, counter_cache: true, touch: true
	validates_associated :lab
	validates_presence_of :lab

	has_many :ownerships
	has_many :users, through: :ownerships

	validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :price, numericality: { greater_than_or_equal_to: 0, message: 'Must be a positive number or 0' }, allow_blank: true
  validates :remaining, numericality: true, allow_blank: true
  validates :serial, unique: false, allow_blank: true, allow_nil: true

  validates :uid, allow_blank: true, uniqueness: { scope: [:lab_id, :category, :name], message: 'There is another reagent in the lab with that category, name and UID' }

  validates_date :expiration, after: lambda { Date.today }, after_message: 'Expiration date must be set after today',
  														if: Proc.new { |reagent| reagent.expiration_changed? }

  before_save :set_expiration, if: Proc.new { |reagent| reagent.expiration.blank? }

	include PublicActivity::Common

	amoeba do
    enable
    customize(lambda { |original_reagent,new_reagent|
    	new_reagent.uid        = SecureRandom.hex(2)
    	new_reagent.remaining  = 100
    	new_reagent.activities = []
      if original_reagent.expiration.past?
        new_reagent.expiration = Date.today + 3.years
      end
      if original_reagent.icon.present?
      	new_reagent.icon = original_reagent.icon
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

	scope :modified_recently, -> { order("updated_at Desc") }
	scope :expired, 					-> { where("expiration < ?", Date.today )}

	# store_accessor :properties, :description

  def gl
    User.find_by(email: self.lab.email)
  end

  def relative_percentage(category)
    self.reagents.where(category: category).count
  end

  def self.expiration_notice
    Reagent.where(expiration: [28.days.from_now, 14.days.from_now]).find_in_batches(batch_size: 50) do |reagents|
      test = []
      reagents.each do |reagent|
        reagent.users.each do |user|
          test << expiration_message(reagent, user)
        end
          test << expiration_message(reagent, reagent.lab)
      end      
      Comment.import(test)
    end
  end

  def self.expiration_message(reagent, recipient)
    if reagent.uid.present? && !reagent.location.present?
      recipient.comments.build(comment: "#{reagent.name}-#{reagent.uid} (#{reagent.category.humanize}) expires soon. Please consider making it Public.")
    elsif !reagent.uid.present? && reagent.location.present?
      recipient.comments.build(comment: "#{reagent.name} (#{reagent.category.humanize}) expires soon. It's location is: #{reagent.location}. Please consider making it Public.")
    elsif reagent.uid.present? && reagent.location.present?
      recipient.comments.build(comment: "#{reagent.name}-#{reagent.uid} (#{reagent.category.humanize}) expires soon. It's location is: #{reagent.location}. Please consider making it Public.")
    else
      recipient.comments.build(comment: "#{reagent.name} (#{reagent.category.humanize}) expires soon. Please consider making it Public.")
    end
  end

  private
  	def set_expiration
			self.expiration = 3.years.from_now
  	end

	  def self.text_search(query)
	    if query.present?
	      @reagents = pg_search(query)
	    else
	      scoped
	    end
	  end
end