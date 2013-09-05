class Lab < ActiveRecord::Base
	belongs_to :department
	belongs_to :institute

	has_many :users, dependent: :destroy
	validates_uniqueness_of :email



	def location
		if self.room.present? && self.department.present?
			"#{self.room} #{department.address}"
		elsif self.room.present? && self.department.blank?
			"#{self.room} #{institute.address}"
		else
			"#{institute.address}"
		end
	end

end
