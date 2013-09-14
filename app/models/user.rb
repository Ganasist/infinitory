class User < ActiveRecord::Base  
  mount_uploader :icon, IconUploader
  acts_as_taggable

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

  before_create :create_lab, :affiliations
  before_update :update_lab, :deauthorize, :affiliations
  
  ROLES = %w[group_leader lab_manager lab_member]
  DESCRIPTIONS = %w[research_associate postdoctoral_researcher doctoral_candidate 
                    master's_student project_student technician other]

  def deauthorize
    if !self.gl? && self.lab_id_changed?
      self.approved = false
      self.lab_id   = lab_id
      self.institute_id = lab.institute_id
      self.department_id = lab.department_id
      self.joined   = Time.now
    end
  end

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

  def location
    institute.city
  end

  def fullname
    if self.last_name.blank?
      self.email
    else
      "#{first_name} #{last_name}"
    end
  end

  def affiliations
    if !gl?
      self.institute_id = lab.institute_id
      self.department_id = lab.department_id
    end
  end

  def gl
    self.lab.users.where(role: "group_leader")
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
      if self.institute_id_changed?
        self.department = nil
      end    
      self.lab.update_attributes(name: self.fullname, email: self.email, department: self.department, institute: self.institute)
    end
  end

  def create_lab
  	if self.gl?      
      self.approved = true
	  	self.lab = Lab.create(name: self.email, email: self.email, department: self.department, institute: self.institute)
    end
  end
end
