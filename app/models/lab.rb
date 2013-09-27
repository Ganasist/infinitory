class Lab < ActiveRecord::Base
	mount_uploader :icon, IconUploader

	extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

	belongs_to :department
	belongs_to :institute

	has_many :users
	has_many :reagents
	
	validates_uniqueness_of :email, message: "This email addresss has already been registered"

	def should_generate_new_friendly_id?
    name_changed?
  end

	def lab_name
		self.name ||= self.email
	end

	def city
		self.institute.city
	end

	def size
		users.count
	end

	def gl
		self.users.where(role: "group_leader").first
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

	def location
		if self.room.present? && self.department.present?
			"#{self.room} #{department.address}"
		elsif self.room.present? && self.department.blank?
			"#{self.room} #{institute.address}"
		else
			"#{institute.address}"
		end
	end

	private

  def slug_candidates
    [
      :lab_name,
      [:lab_name, :id]
    ]
  end
end
