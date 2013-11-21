class Reagent < ActiveRecord::Base

	include PgSearch
  pg_search_scope :search, against: [:name, :category, :serial, :url],
                  using: { tsearch: { prefix: true,
                  										dictionary: "english" }}
	belongs_to :lab
	validates_associated :lab
	validates_presence_of :lab

	has_many :ownerships
	has_many :users, through: :ownerships

	acts_as_taggable

	# store_accessor :properties, :description

	CATEGORIES = %w[antibody cell_culture cell_line chemical_(powder) chemical_(solution) enzyme kit]

	validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :price, numericality: { greater_than_or_equal_to: 0, message: "Must be a positive number or 0" }, allow_blank: true

  def gl
    User.find_by(email: self.lab.email)
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