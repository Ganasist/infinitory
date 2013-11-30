class Reagent < ActiveRecord::Base

	CATEGORIES = %w[antibody cell_culture cell_line chemical_(powder) chemical_(solution) enzyme kit]

	belongs_to :lab, counter_cache: true, touch: true
	validates_associated :lab
	validates_presence_of :lab

	has_many :ownerships
	has_many :users, through: :ownerships

	validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :price, numericality: { greater_than_or_equal_to: 0, message: 'Must be a positive number or 0' }, allow_blank: true
  validates :remaining, numericality: true, allow_blank: true

  validates_date :expiration, after: lambda { Date.today }, after_message: 'Expiration date must be set after today',
  														if: Proc.new { |reagent| reagent.expiration_changed? }

  before_save :set_expiration, if: Proc.new { |reagent| reagent.expiration.blank? }
	
	include PgSearch
  pg_search_scope :search, against: [:name, :category, :serial],
                   				 using: { tsearch: { prefix: true, dictionary: 'english' }}

	mount_uploader :icon, IconUploader
	process_in_background :icon
	
	acts_as_taggable
	scope :modified_recently, -> { order("updated_at DESC") }

	# store_accessor :properties, :description

  def gl
    User.find_by(email: self.lab.email)
  end

  private
  	def set_expiration
			self.expiration = 3.years.from_now
  	end

	  def self.text_search(query)
	    if query.present?
	      search(query)
	    else
	      scoped
	    end
	  end
end