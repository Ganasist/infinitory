class Reagent < ActiveRecord::Base

	belongs_to :lab
	validates_associated :lab
	validates_presence_of :lab

	belongs_to :user
	validates_associated :user

	acts_as_taggable

	store_accessor :properties, :description, :expiration

	CATEGORIES = %w[antibody cell_culture cell_line chemical_(powder) chemical_(solution) enzyme kit]

	validates :name, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }

end