class Lab < ActiveRecord::Base
	mount_uploader :icon, IconUploader

	belongs_to :department
	belongs_to :institute

	has_many :users
	validates_uniqueness_of :email
	validate :gl_unique, message: "Labs can only have 1 group leader"

	def lab_name
		self.name ||= self.email
	end

	def department_name
    department.try(:name)
  end
  
  def department_name=(name)
    self.department = Department.find_or_create_by(name: name, institute_id: self.institute_id) if name.present?
  end

	def institute_name
    institute.try(:name)
  end
  
  def institute_name=(name)
    self.institute = Institute.find_or_create_by(name: name) if name.present?
  end

	def gl
		users.where(role: "group_leader")
	end

	def gl_unique
		users.where(role: "group_leader") == 1
	end

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
