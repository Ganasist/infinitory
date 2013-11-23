class Reagent < ActiveRecord::Base

	include PgSearch
  pg_search_scope :search, against: [:name, :category, :serial],
                   				 using: { tsearch: { prefix: true,
                  														 dictionary: 'english' }}
	
	belongs_to :lab, counter_cache: true, touch: true
	validates_associated :lab
	validates_presence_of :lab

	has_many :ownerships
	has_many :users, through: :ownerships

	acts_as_taggable
	default_scope { order("updated_at DESC") }

	# store_accessor :properties, :description

	CATEGORIES = %w[antibody cell_culture cell_line chemical_(powder) chemical_(solution) enzyme kit]

	validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :price, numericality: { greater_than_or_equal_to: 0, message: "Must be a positive number or 0" }, allow_blank: true

  def gl
    User.find_by(email: self.lab.email)
  end

  def update_with_conflict_validation(*args)
	  update_attributes(*args)
	rescue ActiveRecord::StaleObjectError
	  # errors.add(:base, "this is atest")
	  changes.each do |name, values|
	    errors.add name, "Another member has modified #{name.capitalize} to #{values.first}"
	  end
	  false 
	end

  private
	  def self.text_search(query)
	    if query.present?
	      search(query)
	    else
	      scoped
	    end
	  end
end