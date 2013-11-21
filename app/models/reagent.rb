class Reagent < ActiveRecord::Base

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

end