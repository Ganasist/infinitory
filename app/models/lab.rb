class Lab < ActiveRecord::Base
	mount_uploader :icon, IconUploader

	extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  # include ActiveModel::Validations

	validates :email, uniqueness: { message: 'This email address has already been registered' },
						presence: true

	belongs_to :department
	validates_associated :department
	
	belongs_to :institute
	validates_associated	:institute
	validates :institute, presence: true

	has_many :users
	has_many :reagents

	after_update :lab_name, :lab_email

	def should_generate_new_friendly_id?
  	name_changed?
  end

  def lab_name
  	self.name = gl.fullname
  end

  def lab_email
  	self.email = gl.email
  end

  def gl_count  	
		users.where(role: 'group_leader').count
  end

  def gl
		self.users.find_by(role: 'group_leader')
  end

	def city
		institute.city
	end

	def size
		users.count
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
      :name,
      [:name, :id]
    ]
  end
end
