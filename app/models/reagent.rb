class Reagent < ActiveRecord::Base
	belongs_to :lab, counter_cache: true, touch: true
	validates_associated :lab
	validates_presence_of :lab

	acts_as_taggable

	store_accessor :properties, :description, :expiration

	CATEGORIES = %w[antibody chemical enzyme kit solution]

  validates :category, presence: true, inclusion: { in: CATEGORIES }
end