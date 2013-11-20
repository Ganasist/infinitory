class Reagent < ActiveRecord::Base

	belongs_to :lab
	validates_associated :lab
	validates_presence_of :lab

	has_many :ownerships
	has_many :users, through: :ownerships

	# belongs_to :user
	# validates_associated :user
	# validates_presence_of :user

	acts_as_taggable

	store_accessor :properties, :description, :expiration

	CATEGORIES = %w[antibody cell_culture cell_line chemical_(powder) chemical_(solution) enzyme kit]

	validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :price, numericality: { greater_than_or_equal_to: 0, message: "Must be a positive number or 0" }, allow_blank: true

  def self.user
  	self.user ||= self.lab.gl
  end
end