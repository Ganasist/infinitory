class Reagent < ActiveRecord::Base
	belongs_to :lab	
	validates_associated :lab
	validates_presence_of :lab

	store_accessor :properties, :description, :expiration
end
