class Department < ActiveRecord::Base
	belongs_to :institute
  validates_associated :institute

	geocoded_by :address   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates

end
