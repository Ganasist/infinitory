class Lab < ActiveRecord::Base
	belongs_to :department
	belongs_to :institute

	has_many :users, dependent: :destroy

	def location
		"#{self.room} #{department.address}"
	end

end
