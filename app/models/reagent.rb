class Reagent < ActiveRecord::Base

	# belongs_to :consumable, polymorphic: true, counter_cache: true, touch: true

	belongs_to :lab, counter_cache: true, touch: true
	validates_associated :lab
	validates_presence_of :lab

	belongs_to :user, counter_cache: true, touch: true
	validates_associated :user

	acts_as_taggable

	store_accessor :properties, :description, :expiration

	CATEGORIES = %w[antibody chemical_(powder) chemical_(solution) enzyme kit cell_line]

	validates :name, presence: true
	validates :contact, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }

end