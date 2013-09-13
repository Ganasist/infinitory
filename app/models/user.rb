class User < ActiveRecord::Base  
  mount_uploader :icon, IconUploader

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  belongs_to :institute
  belongs_to :department
  belongs_to :lab

  validates_presence_of :lab, message: "Your group leader must create an account first", unless: :gl?
  validates_presence_of :institute_name, message: "You must enter your institute's name", if: :gl?
  validates_uniqueness_of :email, message: "That email address has already been registered"
  validates_presence_of :role
  validates_presence_of :department_id, allow_blank: true

  before_create :affiliations, :create_lab
  before_update :update_lab
  
  ROLES = %w[group_leader lab_manager lab_member]
  DESCRIPTIONS = %w[research_associate postdoctoral_researcher doctoral_candidate master's_student project_student technician other]

  # def authorize
  #   self.approved = true
  # end

  def active_for_authentication? 
    super && approved? 
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end

  def fullname
    if self.last_name.blank?
      self.email
    else
      "#{first_name} #{last_name}"
    end
  end

  def affiliations
    if self.gl?
      self.approved = true
    else
      self.institute_id = lab.institute_id
      self.department_id = lab.department_id
    end
  end

  def gl?
    self.role == "group_leader"
  end

  def gl_lm?
    self.role == "group_leader" || self.role == "lab_manager"
  end

  def lm?
    self.role == "lab_manager"    
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

  def update_lab
    if self.gl?
      self.lab.update_attributes(name: self.fullname, email: self.email, department: self.department, institute: self.institute)
    end
  end

  def create_lab
  	if self.gl?
	  	self.lab = Lab.create(name: self.email, email: self.email, department: self.department, institute: self.institute)
    end
  end
end
