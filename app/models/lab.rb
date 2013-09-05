class Lab < ActiveRecord::Base
	belongs_to :department
	belongs_to :institute

	has_many :users, dependent: :destroy

	def location
		if self.room.present?
			"#{self.room} #{department.address}"
		else
			"#{department.address}"
		end
	end

end
