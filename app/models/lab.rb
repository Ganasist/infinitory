class Lab < ActiveRecord::Base
	validates :email, presence: true

	belongs_to :department, counter_cache: true, touch: true
	validates_associated :department
	
	belongs_to :institute, counter_cache: true, touch: true
	validates_associated	:institute
	validates :institute, presence: true

	has_many :users
  has_many :reagents

  mount_uploader :icon, IconUploader
  process_in_background :icon

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  before_update :lab_name, if: Proc.new{ |l| l.gl.present? }
  before_update :lab_email, if: Proc.new{ |l| l.gl.present? }

  def lab_name
  	self.name = gl.fullname
  end

  def lab_email
  	self.email = gl.email
  end

  def institute_name
  	self.institute.name
  end

  def gl_count  	
		self.users.where(role: 'group_leader').count
  end

  def gl
		User.find_by(email: self.email)
  end

	def city
		institute.city
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

	private

	def should_generate_new_friendly_id?
  	name_changed?
  end

  def slug_candidates
    [
      :name,
      [:name, :city]
    ]
  end
end
