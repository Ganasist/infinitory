class Reagent < ActiveRecord::Base
	belongs_to :lab	
	validates_associated :lab

	store_accessor :properties, :description, :expiration
end
